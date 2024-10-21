import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FetchAddToCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KAI Data Display'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('CART').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                Map<String, dynamic>? data =
                    documents[index].data() as Map<String, dynamic>?; // Explicit casting
                if (data != null) {
                  return DataCard(data: data, onDelete: () {
                    // Delete card and update KAI table
                    FirebaseFirestore.instance.collection('CART').doc(documents[index].id).delete();
                  });
                } else {
                  return SizedBox(); // Return an empty widget if data is null
                }
              },
            );
          }
        },
      ),
    );
  }
}

class DataCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final VoidCallback onDelete;

  const DataCard({Key? key, required this.data, required this.onDelete}) : super(key: key);

  @override
  _DataCardState createState() => _DataCardState();
}

class _DataCardState extends State<DataCard> {
  int pendingStatusIndex = 0; // Index for the pending status options
  int prepareStatusIndex = 0; // Index for the prepare status options

  final List<String> pendingStatusOptions = ['Pending', 'Reject', 'Approve']; // Status options for pending
  final List<String> prepareStatusOptions = ['Prepare', 'Reject', 'Delivery']; // Status options for prepare

  final Map<String, Color> statusColors = {
    'Pending': Colors.black,
    'Reject': Colors.red,
    'Approve': Colors.green,
    'Prepare': Colors.black,
    'Delivery': Colors.green,
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        // Show confirmation dialog
        bool delete = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Delete Card?'),
            content: Text('Are you sure you want to delete this card?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Don't delete
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Confirm deletion
                },
                child: Text('Yes'),
              ),
            ],
          ),
        );

        // If user confirms deletion, call onDelete callback
        if (delete != null && delete) {
          widget.onDelete();
        }
      },
      child: Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(widget.data['selectedImage']),
              SizedBox(height: 8),
              Text('User Data:'),
              Text('Name: ${widget.data['userData']['name']}'),
              Text('Email: ${widget.data['userData']['email']}'),
              Text('Address: ${widget.data['userData']['address']}'),
              Text('Phone: ${widget.data['userData']['phone']}'),
              Text('Total Price: ${widget.data['totalPrice']}'),
              SizedBox(height: 8),
              Text('Products:'),
              ExpansionTile(
                title: Text('Products'),
                children: [
                  for (var product in widget.data['products']) ProductCard(product: product),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            pendingStatusIndex = (pendingStatusIndex + 1) % pendingStatusOptions.length;
                          });
                        },
                        child: Text(
                          pendingStatusOptions[pendingStatusIndex],
                          style: TextStyle(color: Colors.white), // Set text color to white
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(120, 40),
                          backgroundColor: statusColors[pendingStatusOptions[pendingStatusIndex]],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            prepareStatusIndex = (prepareStatusIndex + 1) % prepareStatusOptions.length;
                          });
                        },
                        child: Text(
                          prepareStatusOptions[prepareStatusIndex],
                          style: TextStyle(color: Colors.white), // Set text color to white
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(120, 40),
                          backgroundColor: statusColors[prepareStatusOptions[prepareStatusIndex]],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String? imagePath) {
    if (imagePath != null && imagePath.isNotEmpty) {
      if (imagePath.startsWith('http')) {
        // Network image
        return Image.network(
          imagePath,
          width: 400,
          height: 550,
          fit: BoxFit.cover,
        );
      } else {
        // Local file image
        return Image.file(
          File(imagePath),
          width: 400,
          height: 450,
          fit: BoxFit.contain,
        );
      }
    } else {
      // Placeholder if image path is null or empty
      return SizedBox();
    }
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product Name: ${product['productName']}'),
            Text('Quantity: ${product['quantity']}'),
            Text('Selected Size: ${product['selectedSize']}'),
            Text('Selected Price: ${product['selectedPrice']}'),
            SizedBox(height: 8),
            _buildProductImage(product['imagePath']), // Display product image
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(String? imagePath) {
    if (imagePath != null && imagePath.isNotEmpty) {
      if (imagePath.startsWith('http')) {
        // Network image
        return Image.network(
          imagePath,
          width: 200,
          height: 100,
          fit: BoxFit.cover,
        );
      } else {
        // Local file image
        return Image.file(
          File(imagePath),
          width: 200,
          height: 100,
          fit: BoxFit.cover,
        );
      }
    } else {
      // Placeholder if image path is null or empty
      return SizedBox();
    }
  }
}
