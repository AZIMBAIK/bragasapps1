import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class RetriveUserTripReg extends StatefulWidget {
  @override
  _RetriveUserTripRegState createState() => _RetriveUserTripRegState();
}

class _RetriveUserTripRegState extends State<RetriveUserTripReg> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Data Display'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('love').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data available'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              return StatusCard(document: doc);
            },
          );
        },
      ),
    );
  }
}

class StatusCard extends StatefulWidget {
  final QueryDocumentSnapshot document;

  StatusCard({required this.document});

  @override
  _StatusCardState createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> {
  String currentStatus = 'Pending';

  @override
 void initState() {
  super.initState();
  var data = widget.document.data() as Map<String, dynamic>?; // Cast data to Map<String, dynamic> or nullable
  if (data != null && data.containsKey('status')) {
    currentStatus = data['status'];
  }
}

  void toggleStatus() {
    String nextStatus = currentStatus == 'Pending' ? 'Approve' : (currentStatus == 'Approve' ? 'Reject' : 'Pending');
    setState(() {
      currentStatus = nextStatus;
    });
  }

  void updateAllData() {
    // Perform a Firestore update to save the current UI status and other data
    widget.document.reference.update({
      'status': currentStatus,  // Update the status based on the UI
      // Update additional fields as needed here
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All data updated successfully!')));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating data: $error')));
    });
  }

  Color getStatusColor() {
    switch (currentStatus) {
      case 'Approve':
        return Colors.blue;
      case 'Reject':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

@override
Widget build(BuildContext context) {
  var data = widget.document.data() as Map<String, dynamic>;
  return Card(
    elevation: 5,
    margin: EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.file(
          File(data['imagePath'] ?? ''),
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data['packageName'] ?? '', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Limit: ${data['limit'] ?? 'N/A'}'),
              Text('Price: \$${data['totalPrice'] ?? 'N/A'}'),
              Text('Timestamp: ${data['timestamp']?.toDate().toString() ?? 'N/A'}'),
              ExpansionTile(
                title: Row(
                  children: [
                    Text('Products'),
                    Spacer(), // Push the Approve button to the right side
                    TextButton(
                      onPressed: toggleStatus,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        backgroundColor: getStatusColor(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(currentStatus, style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                children: [
                  Divider(),
                  ListTile(
                    title: Text('Name: ${data['name'] ?? 'N/A'}'),
                  ),
                  ListTile(
                    title: Text('Email: ${data['email'] ?? 'N/A'}'),
                  ),
                  ListTile(
                    title: Text('Phone: ${data['phone'] ?? 'N/A'}'),
                  ),
                  ListTile(
                    title: Text('Address: ${data['address'] ?? 'N/A'}'),
                  ),
                ],
              ),
              SizedBox(height: 10), // Add some space between ExpansionTile and buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end, // Align the buttons to the right side
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: updateAllData,
                    child: Text("Update All Data"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}