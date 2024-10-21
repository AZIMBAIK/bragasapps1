import 'dart:io';

import 'package:bragasapps1/bragas_group/fetchDataAddToCart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class allShippingOrderU2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   final FirebaseAuth _auth = FirebaseAuth.instance;
   String currentUid = _auth.currentUser!.uid; 
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Combined Data Display'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           FetchAddToCart(),
           FetchBuy(currentUid: currentUid),
          ],
        ),
      ),
    );
  }
}

class FetchAddToCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the current user's UID
    final String? userUid = FirebaseAuth.instance.currentUser?.uid;

    if (userUid == null) {
      return Center(child: Text("No user logged in"));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'CART Data',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      StreamBuilder(
  stream: FirebaseFirestore.instance
      .collection('CART')
      .where('userData.uid', isEqualTo: userUid)
      .snapshots(),
  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else {
      // Ensure the snapshot's data exists before proceeding
      if (snapshot.data == null) {
        return Center(child: Text('No data available'));
      }

      List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = snapshot.data!.docs;
      // Filter documents after safely casting to Map<String, dynamic>
      documents = documents.where((doc) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        return data != null &&
               data.containsKey('status22') &&
               data.containsKey('status23') &&
               data['status22'] == 'Approve' &&
               data['status23'] == 'Delivery';
      }).toList();

      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: documents.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
          return DataCard(
            data: data,
            document: documents[index], // Pass the document reference
            onDelete: () {
              FirebaseFirestore.instance.collection('CART').doc(documents[index].id).delete();
            },
          );
        },
      );
    }
  },
),


      ],
    );
  }
}

class DataCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final DocumentSnapshot document; // Document reference
  final VoidCallback onDelete;

  const DataCard({Key? key, required this.data, required this.document, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status22 = data['status22'] ?? 'Pending';
    final status23 = data['status23'] ?? 'Prepare';

    final Map<String, Color> statusColors = {
      'Approve': Colors.green,
      'Reject': Colors.red,
      'Pending': Colors.black,
    };

    final Map<String, Color> deliveryStatusColors = {
      'Prepare': Colors.blue,
      'Delivery': Colors.green,
    };

    return GestureDetector(
      onLongPress: () async {
        bool delete = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Delete Card?'),
            content: Text('Are you sure you want to delete this card?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Yes'),
              ),
            ],
          ),
        );

        if (delete != null && delete) {
          onDelete();
        }
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(data['selectedImage']),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('User Data:', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${data['userData']['name']}'),
                  Text('Email: ${data['userData']['email']}'),
                  Text('Address: ${data['userData']['address']}'),
                  Text('Phone: ${data['userData']['phone']}'),
                  Text('Total Price: ${data['totalPrice']}'),
                ],
              ),
            ),
            SizedBox(height: 8),
            Text('Products:', style: TextStyle(fontWeight: FontWeight.bold)),
            ExpansionTile(
              title: Text('Products'),
              childrenPadding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                for (var product in data['products']) ProductCard(product: product),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    color: statusColors[status22],
                    child: Center(
                      child: Text(
                        status22,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    color: deliveryStatusColors[status23],
                    child: Center(
                      child: Text(
                        status23,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String? imagePath) {
    if (imagePath != null && imagePath.isNotEmpty) {
      if (imagePath.startsWith('http')) {
        return Image.network(
          imagePath,
          width: 400,
          height: 550,
          fit: BoxFit.cover,
        );
      } else {
        return Image.file(
          File(imagePath),
          width: 400,
          height: 450,
          fit: BoxFit.contain,
        );
      }
    } else {
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
            _buildProductImage(product['imagePath']),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(String? imagePath) {
    if (imagePath != null && imagePath.isNotEmpty) {
      if (imagePath.startsWith('http')) {
        return Image.network(
          imagePath,
          width: 200,
          height: 100,
          fit: BoxFit.cover,
        );
      } else {
        return Image.file(
          File(imagePath),
          width: 200,
          height: 100,
          fit: BoxFit.cover,
        );
      }
    } else {
      return SizedBox();
    }
  }
}
















class FetchBuy extends StatelessWidget {
  final String currentUid;

  const FetchBuy({required this.currentUid});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'BUY Data',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('BUY').where('uid', isEqualTo: currentUid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (snapshot.hasData) {
              final data = snapshot.data!;
              // Filter out documents where 'status1' is 'Pending' and 'status2' is either 'Prepare' or 'Reject'
              final filteredData = data.docs.where((doc) {
                Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;
                return docData['status1'] == 'Approve' && 
                       (docData['status2'] == 'Delivery');
              }).toList();

              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  final document = filteredData[index];
                  return KaiDataItem(document: document);
                },
              );
            } else {
              return Center(child: Text("No data available"));
            }
          },
        ),
      ],
    );
  }
}


class KaiDataItem extends StatefulWidget {
  final QueryDocumentSnapshot document;

  const KaiDataItem({required this.document});

  @override
  _KaiDataItemState createState() => _KaiDataItemState();
}

class _KaiDataItemState extends State<KaiDataItem> {
  late String status1;
  late String status2;
  Color statusColor = Colors.black;
  Color deliveryStatusColor = Colors.black;

  @override
  void initState() {
    super.initState();
    // Initialize status1 and status2 from document data
    status1 = widget.document['status1'];
    status2 = widget.document['status2'];

    // Update status colors
    _updateStatusColor();
    _updateDeliveryStatusColor();

    // Listen to changes in Firestore data
    widget.document.reference.snapshots().listen((snapshot) {
      setState(() {
        // Update status1 and status2 from updated snapshot data
        status1 = snapshot['status1'];
        status2 = snapshot['status2'];

        // Update status colors
        _updateStatusColor();
        _updateDeliveryStatusColor();
      });
    });
  }

  void _updateStatusColor() {
    switch (status1) {
      case 'Approve':
        statusColor = Colors.green;
        break;
      case 'Reject':
        statusColor = Colors.red;
        break;
      case 'Pending':
        statusColor = Colors.black;
        break;
    }
  }

  void _updateDeliveryStatusColor() {
    switch (status2) {
      case 'Delivery':
        deliveryStatusColor = Colors.green;
        break;
      case 'Prepare':
        deliveryStatusColor = Colors.blue;
        break;
        case 'Complete':
        deliveryStatusColor = const Color.fromARGB(255, 40, 243, 33);
        break;
    }
  }

  void _deleteData() async {
    try {
      await widget.document.reference.delete();
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = widget.document['imagePath'];
    final productName = widget.document['productName'];
    final quantity = widget.document['quantity'];
    final receiptPaymentImage = widget.document['receiptPaymentImage'];
    final selectedPaymentType = widget.document['selectedPaymentType'];
    final selectedPrice = widget.document['selectedPrice'];
    final selectedSize = widget.document['selectedSize'];
    final totalCost = widget.document['totalCost'];
    final userAddress = widget.document['userAddress'];
    final userEmail = widget.document['userEmail'];
    final userName = widget.document['userName'];
    final userPhone = widget.document['userPhone'];

    // Display image if receiptPaymentImage is not null and not empty
    Widget receiptImageWidget = SizedBox();
    if (receiptPaymentImage != null && receiptPaymentImage.isNotEmpty) {
      receiptImageWidget = Image.file(
        File(receiptPaymentImage),
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      );
    }

    Widget imagePathWidget = SizedBox();
    if (imagePath != null && imagePath.isNotEmpty) {
      imagePathWidget = Image.file(
        File(imagePath),
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      );
    }

    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Delete Card?'),
              content: Text('Are you sure you want to delete this card?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    _deleteData();
                    Navigator.of(context).pop();
                  },
                  child: Text('Delete'),
                ),
              ],
            );
          },
        );
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (receiptImageWidget != SizedBox()) receiptImageWidget,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'User Email: $userEmail',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Name: $userName',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Address: $userAddress',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Phone: $userPhone',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Total Cost: $totalCost',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Products:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  ExpansionTile(
                    title: Text('Products'),
                    children: [
                      Divider(),
                      ListTile(
                        title: Text(
                          'Product Name: $productName',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Quantity: $quantity',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Selected Payment Type: $selectedPaymentType',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Selected Price: $selectedPrice',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Selected Size: $selectedSize',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      if (imagePathWidget != SizedBox()) imagePathWidget,
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 12, // Adjust width as needed
                        height: 70, // Adjust height as needed
                        color: statusColor,
                        child: Center(
                          child: Text(
                            'Status: $status1',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2 - 12, // Adjust width as needed
                          height: 70, // Adjust height as needed
                          color: deliveryStatusColor,
                          child: Center(
                            child: Text(
                              'Delivery: $status2',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}