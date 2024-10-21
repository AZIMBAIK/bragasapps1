import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class addTrip extends StatefulWidget {
  @override
  _addTripState createState() => _addTripState();
}

class _addTripState extends State<addTrip> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController packageNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController limitController = TextEditingController();
  String? _selectedImagePath;
  DateTime? _selectedDate;

  void _registerProduct() {
    if (_selectedImagePath != null &&
        packageNameController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        _selectedDate != null &&
        limitController.text.isNotEmpty) {
      _firestore.collection('adminPostPoster').add({
        'packageName': packageNameController.text,
        'imagePath': _selectedImagePath,
        'price': double.parse(priceController.text),
        'limit': int.parse(limitController.text),
        'date': DateFormat('yyyy-MM-dd').format(_selectedDate!),
        'timestamp': Timestamp.now(),
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product registered successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
        packageNameController.clear();
        priceController.clear();
        limitController.clear();
        setState(() {
          _selectedImagePath = null;
          _selectedDate = null;
        });
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to register product. Please try again.'),
            duration: Duration(seconds: 2),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields and select an image.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Registration', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(5, 30, 5, 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey[100]!, Colors.blueGrey[300]!],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _selectedImagePath != null
                        ? Image.file(
                            File(_selectedImagePath!),
                            fit: BoxFit.cover,
                          )
                        : Icon(Icons.add_photo_alternate, size: 50),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: packageNameController,
                  decoration: InputDecoration(
                    labelText: 'Package Name',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white70,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white70,
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: limitController,
                  decoration: InputDecoration(
                    labelText: 'Limit seat',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white70,
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'Select Date'
                          : 'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _registerProduct,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    child: Text('Add Trip', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';

// class addTrip extends StatefulWidget {
//   @override
//   _addTripState createState() => _addTripState();
// }

// class _addTripState extends State<addTrip> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   TextEditingController packageNameController = TextEditingController();
//   TextEditingController priceController = TextEditingController();
//   TextEditingController limitController = TextEditingController(); // New controller for limit
//   String? _selectedImagePath;
//   DateTime? _selectedDate;

//   void _registerProduct() {
//     if (_selectedImagePath != null &&
//         packageNameController.text.isNotEmpty &&
//         priceController.text.isNotEmpty &&
//         _selectedDate != null &&
//         limitController.text.isNotEmpty) {
//       _firestore.collection('adminPostPoster').add({
//         'packageName': packageNameController.text,
//         'imagePath': _selectedImagePath,
//         'price': double.parse(priceController.text),
//         'limit': int.parse(limitController.text),
//         'date': DateFormat('yyyy-MM-dd').format(_selectedDate!),
//         'timestamp': Timestamp.now(),
//       }).then((value) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Product registered successfully!'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//         packageNameController.clear();
//         priceController.clear();
//         limitController.clear();
//         setState(() {
//           _selectedImagePath = null;
//           _selectedDate = null;
//         });
//       }).catchError((error) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to register product. Please try again.'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please fill all fields and select an image.'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _selectedImagePath = pickedFile.path;
//       });
//     }
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );

//     if (pickedDate != null && pickedDate != _selectedDate) {
//       setState(() {
//         _selectedDate = pickedDate;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Product Registration'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTap: _pickImage,
//               child: Container(
//                 width: 100,
//                 height: 100,
//                 decoration: BoxDecoration(
//                   border: Border.all(width: 1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: _selectedImagePath != null
//                     ? Image.file(
//                         File(_selectedImagePath!),
//                         fit: BoxFit.cover,
//                       )
//                     : Icon(Icons.add_photo_alternate),
//               ),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: packageNameController,
//               decoration: InputDecoration(
//                 labelText: 'Package Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: priceController,
//               decoration: InputDecoration(
//                 labelText: 'Price',
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: limitController,
//               decoration: InputDecoration(
//                 labelText: 'Limit seat',
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Text(
//                   _selectedDate == null
//                       ? 'Select Date'
//                       : 'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.calendar_today),
//                   onPressed: () => _selectDate(context),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             Container(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _registerProduct,
//                 child: Text('Add Trip'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

