import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late Map<DateTime, List<String>> _events;
  late int _currentMonth;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _currentMonth = _focusedDay.month;
    _events = {};
    _fetchEventsFromFirestore(_focusedDay.month);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plan Trip 2024',style: TextStyle(fontWeight: FontWeight.bold,),),
      centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            eventLoader: (day) {
              return _events[day] ?? [];
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
                _currentMonth = focusedDay.month;
              });
              _fetchEventsFromFirestore(focusedDay.month);
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              selectedTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    bottom: 1,
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                color: Colors.grey.shade200,
                child: _buildUpcomingEvents(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addEvent();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildUpcomingEvents() {
    final upcomingEvents = _events.entries.where((entry) => entry.key.month == _currentMonth).toList();
    if (upcomingEvents.isEmpty) {
      return Center(
        child: Text(
          'No upcoming events',
          style: TextStyle(fontSize: 16),
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(
                'Upcoming Events',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.zero,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: upcomingEvents.length,
              itemBuilder: (context, index) {
                final day = upcomingEvents[index].key;
                final events = upcomingEvents[index].value;
                return _buildEventCard(day, events);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget _buildEventCard(DateTime day, List<String> events) {
    return GestureDetector(
      onLongPress: () => _confirmDeleteEvent(day, events),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_formatDateTime(day)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              ...events.map((event) => Text(
                event,
                style: TextStyle(fontSize: 16),
              )),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  void _addEvent() async {
    final TextEditingController controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Event'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: 'Event Name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final eventDate = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
                final eventName = controller.text;

                setState(() {
                  if (_events.containsKey(eventDate)) {
                    _events[eventDate]!.add(eventName);
                  } else {
                    _events[eventDate] = [eventName];
                  }
                });

                await _saveEventToFirestore(eventDate, eventName); // Save event to Firestore

                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteEvent(DateTime day, List<String> events) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Event?'),
          content: Text('Are you sure you want to delete this event?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final eventName = events.first; // Assume the event list has at least one event
                setState(() {
                  _events[day]!.removeWhere((event) => events.contains(event));
                  if (_events[day]!.isEmpty) {
                    _events.remove(day);
                  }
                });
                await _deleteEventFromFirestore(day, eventName); // Delete event from Firestore
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveEventToFirestore(DateTime eventDate, String eventName) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('plantTrip').add({
        'date': eventDate,
        'name': eventName,
      });
      print('Event added to Firestore');
    } catch (error) {
      print('Failed to add event: $error');
    }
  }

  Future<void> _deleteEventFromFirestore(DateTime day, String eventName) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      final QuerySnapshot snapshot = await firestore.collection('plantTrip')
          .where('date', isEqualTo: Timestamp.fromDate(day))
          .where('name', isEqualTo: eventName)
          .get();

      for (final DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }

      print('Event(s) deleted from Firestore');
    } catch (error) {
      print('Failed to delete event: $error');
    }
  }

  bool isSameDay(DateTime dayA, DateTime dayB) {
    return dayA.year == dayB.year && dayA.month == dayB.month && dayA.day == dayB.day;
  }

  void _fetchEventsFromFirestore(int month) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      final QuerySnapshot snapshot = await firestore.collection('plantTrip')
          .where('date', isGreaterThanOrEqualTo: DateTime(DateTime.now().year, month, 1))
          .where('date', isLessThanOrEqualTo: DateTime(DateTime.now().year, month + 1, 0))
          .get();
      _events = {};
      snapshot.docs.forEach((doc) {
        final eventDate = (doc['date'] as Timestamp).toDate();
        final eventName = doc['name'] as String;
        _events.update(eventDate, (value) => [...value, eventName], ifAbsent: () => [eventName]);
      });
      setState(() {});
    } catch (error) {
      print('Failed to fetch events: $error');
    }
  }
}
