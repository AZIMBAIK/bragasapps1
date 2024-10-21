import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UpdateTrip extends StatefulWidget {
  @override
  _UpdateTripState createState() => _UpdateTripState();
}

class _UpdateTripState extends State<UpdateTrip> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Trip',style: TextStyle(fontWeight: FontWeight.bold,),),
      centerTitle: true,),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('adminPostPoster').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var document = snapshot.data!.docs[index];
                var tripData = document.data() as Map<String, dynamic>;
                return _buildTripCard(context, tripData, document.id);
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildTripCard(BuildContext context, Map<String, dynamic> tripData, String documentId) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(tripData['imagePath']),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tripData['packageName'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Price: ${tripData['price']}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Limit: ${tripData['limit']}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(tripData['date']))}',
                  style: TextStyle(fontSize: 16), // Ensure consistent format
                ),
              ],
            ),
          ),
          ButtonBar(
            children: [
              ElevatedButton(
                onPressed: () => _updateTrip(context, documentId),
                child: Text('Update'),
              ),
              ElevatedButton(
                onPressed: () => _deleteTrip(context, documentId),
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String imagePath) {
    if (imagePath.isNotEmpty) {
      return Image.file(
        File(imagePath),
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      );
    } else {
      return Container(
        width: double.infinity,
        height: 200,
        color: Colors.grey[300],
        child: Icon(Icons.image),
      );
    }
  }

  void _updateTrip(BuildContext context, String documentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? packageName;
        double? price;
        int? limit;
        DateTime? selectedDate;
        File? newImage;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Update Trip'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Package Name:'),
                    TextField(
                      onChanged: (value) => packageName = value,
                      decoration: InputDecoration(
                        hintText: 'Enter package name',
                      ),
                    ),
                    SizedBox(height: 16),
                    Text('Price:'),
                    TextField(
                      onChanged: (value) => price = double.tryParse(value),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter price',
                      ),
                    ),
                    SizedBox(height: 16),
                    Text('Limit:'),
                    TextField(
                      onChanged: (value) => limit = int.tryParse(value),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter limit',
                      ),
                    ),
                    SizedBox(height: 16),
                    Text('Date:'),
                    GestureDetector(
                      onTap: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(selectedDate != null
                            ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                            : 'Select date'),
                      ),
                    ),
                    SizedBox(height: 16),
                    newImage != null
                        ? Image.file(
                            newImage!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : SizedBox.shrink(),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () async {
                        final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                        if (pickedImage != null) {
                          setState(() {
                            newImage = File(pickedImage.path);
                          });
                        }
                      },
                      child: Text('Choose Image'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (packageName != null || price != null || limit != null || selectedDate != null || newImage != null) {
                      final Map<String, dynamic> updatedData = {};
                      if (packageName != null) updatedData['packageName'] = packageName!;
                      if (price != null) updatedData['price'] = price!;
                      if (limit != null) updatedData['limit'] = limit!;
                      if (selectedDate != null) updatedData['date'] = DateFormat('yyyy-MM-dd').format(selectedDate!); // Format date before updating
                      if (newImage != null) {
                        // Upload image to Firebase Storage and get the URL
                        // For simplicity, I'm not implementing the image upload here
                        // You can refer to the Firebase Storage documentation for uploading images
                        // Once uploaded, get the URL and update the 'imagePath' field in Firestore
                        // updatedData['imagePath'] = imageURL;

                        // Update the image path in the trip data
                        updatedData['imagePath'] = newImage!.path;

                        // Update the card UI by calling setState on the parent widget
                        setState(() {});
                      }
                      // Update trip details in Firestore
                      await _firestore.collection('adminPostPoster').doc(documentId).update(updatedData);
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter/update at least one field.')));
                    }
                  },
                  child: Text('Update'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deleteTrip(BuildContext context, String documentId) async {
    // Delete trip data from Firestore
    await _firestore.collection('adminPostPoster').doc(documentId).delete();
    // Close the dialog
    Navigator.of(context).pop();
  }
}

void main() {
  runApp(MaterialApp(
    home: UpdateTrip(),
  ));
}
