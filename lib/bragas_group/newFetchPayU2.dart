import 'dart:io'; // Import IO library for File class
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class newFetchPay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KAI Data List'),
      ),
      body: KaiDataListView(),
    );
  }
}

class KaiDataListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('KAI').snapshots(),
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
        final data = snapshot.data!;
        return ListView.builder(
          itemCount: data.size,
          itemBuilder: (context, index) {
            final document = data.docs[index];
            return KaiDataItem(document: document);
          },
        );
      },
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
  String status = 'Pending';
  String deliveryStatus = 'Delivery';
  Color statusColor = Colors.black;
  Color deliveryStatusColor = Colors.black;
  bool _isExpanded = false;

  void _updateStatusColor() {
    setState(() {
      switch (status) {
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
    });
  }

  void _updateDeliveryStatusColor() {
    setState(() {
      switch (deliveryStatus) {
        case 'Delivery':
          deliveryStatusColor = Colors.green;
          break;
        case 'Prepare':
          deliveryStatusColor = Colors.blue;
          break;
      }
    });
  }

  void _deleteData() async {
    try {
      await widget.document.reference.delete();
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  void _updateData() async {
    try {
      await widget.document.reference.update({
        'status': status,
        'deliveryStatus': deliveryStatus,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data Updated Successfully'),
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      print('Error updating document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final productName = widget.document['productName'];
    final selectedSize = widget.document['selectedSize'];
    final selectedPrice = widget.document['selectedPrice'];
    final quantity = widget.document['quantity'];
    final receiptPaymentImage = widget.document['receiptPaymentImage'];
    final name = widget.document['name'];
    final phone = widget.document['phone'];
    final address = widget.document['address'];
    final email = widget.document['email'];
    final uid = widget.document['uid'];

    // Display image if receiptPaymentImage is not null and not empty
    Widget receiptImageWidget = SizedBox();
    if (receiptPaymentImage != null && receiptPaymentImage.isNotEmpty) {
      receiptImageWidget = Image.file(
        File(receiptPaymentImage),
        width: double.infinity,
        height: 550,
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      color: Colors.blue,
                      child: Text(
                        _isExpanded ? 'Collapse' : 'Expand',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  if (_isExpanded) ...[
                    SizedBox(height: 8),
                    Text('Product Name: $productName'),
                    Text('Size: $selectedSize'),
                    Text('Price: $selectedPrice'),
                    Text('Quantity: $quantity'),
                    Text('Name: $name'),
                    Text('Phone: $phone'),
                    Text('Address: $address'),
                    Text('Email: $email'),
                    Text('UID: $uid'),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                switch (status) {
                                  case 'Approve':
                                    status = 'Reject';
                                    break;
                                  case 'Reject':
                                    status = 'Pending';
                                    break;
                                  case 'Pending':
                                    status = 'Approve';
                                    break;
                                }
                                _updateStatusColor();
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              color: statusColor,
                              child: Text(
                                'Status: $status',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                switch (deliveryStatus) {
                                  case 'Delivery':
                                    deliveryStatus = 'Prepare';
                                    break;
                                  case 'Prepare':
                                    deliveryStatus = 'Delivery';
                                    break;
                                }
                                _updateDeliveryStatusColor();
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              color: deliveryStatusColor,
                              child: Text(
                                'Delivery: $deliveryStatus',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _updateData,
                      child: Text('Update'),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
