import 'dart:io';

import 'package:bragasapps1/bragas_group/fetchDataAddToCart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FetchProductHas2U2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Combined Data Display'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FetchAddToCart(),
            FetchBuy(),
          ],
        ),
      ),
    );
  }
}












class FetchAddToCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          stream: FirebaseFirestore.instance.collection('CART').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<DocumentSnapshot> documents = snapshot.data!.docs;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic>? data = documents[index].data() as Map<String, dynamic>?; // Explicit casting
                  if (data != null) {
                    return DataCard(
                      data: data,
                      document: documents[index], // Pass the document reference
                      onDelete: () {
                        FirebaseFirestore.instance.collection('CART').doc(documents[index].id).delete();
                      },
                    );
                  } else {
                    return SizedBox(); // Return an empty widget if data is null
                  }
                },
              );
            }
          },
        ),
      ],
    );
  }
}

class DataCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final DocumentSnapshot document; // Document reference
  final VoidCallback onDelete;

  const DataCard({Key? key, required this.data, required this.document, required this.onDelete}) : super(key: key);

  @override
  _DataCardState createState() => _DataCardState();
}

class _DataCardState extends State<DataCard> {
  int statusIndex = 0;
  int deliveryStatusIndex = 0;

  final List<String> status22 = ['Approve', 'Reject', 'Pending'];
  final List<String> status23 = ['Prepare', 'Delivery','Complete'];

  final Map<String, Color> statusColors = {
    'Approve': Colors.green,
    'Reject': Colors.red,
    'Pending': Colors.black,
  };

  final Map<String, Color> deliveryStatusColors = {
    'Prepare': Colors.blue,
    'Delivery': Colors.green,
     'Complete': Colors.green,
  };

  @override
  Widget build(BuildContext context) {
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
          widget.onDelete();
        }
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(widget.data['selectedImage']),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('User Data:', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${widget.data['userData']['name']}'),
                  Text('Email: ${widget.data['userData']['email']}'),
                  Text('Address: ${widget.data['userData']['address']}'),
                  Text('Phone: ${widget.data['userData']['phone']}'),
                  Text('Total Price: ${widget.data['totalPrice']}'),
                ],
              ),
            ),
            SizedBox(height: 8),
            Text('Products:', style: TextStyle(fontWeight: FontWeight.bold)),
            ExpansionTile(
              title: Text('Products'),
              childrenPadding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                for (var product in widget.data['products']) ProductCard(product: product),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        statusIndex = (statusIndex + 1) % status22.length;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      color: statusColors[status22[statusIndex]],
                      child: Center(
                        child: Text(
                          status22[statusIndex],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        deliveryStatusIndex = (deliveryStatusIndex + 1) % status23.length;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      color: deliveryStatusColors[status23[deliveryStatusIndex]],
                      child: Center(
                        child: Text(
                          status23[deliveryStatusIndex],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _updateData, // Call _updateData method
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateData() async {
    try {
      await widget.document.reference.update({
        'status22': status22[statusIndex], // Update status22
        'status23': status23[deliveryStatusIndex], // Update status23
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data Updated Successfully'),
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      print('Error updating document: $e');
    }
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
          stream: FirebaseFirestore.instance.collection('BUY').snapshots(),
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
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data.size,
              itemBuilder: (context, index) {
                final document = data.docs[index];
                return KaiDataItem(document: document);
              },
            );
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
  String status1 = 'Pending';
  String status2 = 'Delivery';
  Color statusColor = Colors.black;
  Color deliveryStatusColor = Colors.black;
  

  void _updateStatusColor() {
    setState(() {
      switch (status1) {
        case 'Pending':
          statusColor = Colors.black;
          break;
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
        switch (status2) {
            case 'Complete':
                deliveryStatusColor = Colors.green;  // Complete uses green
                break;
            case 'Delivery':
                deliveryStatusColor = Colors.green;  // Delivery uses green
                break;
            case 'Prepare':
                deliveryStatusColor = Colors.blue;  // Prepare uses blue
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
        'status1': status1,
        'status2': status2,
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
                  GestureDetector(
                  
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                     
                    ),
                  ),
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
      height: 70,  // Adjust height as needed
      child: GestureDetector(
        onTap: () {
          setState(() {
            switch (status1) {
              case 'Approve':
                status1 = 'Reject';
                break;
              case 'Reject':
                status1 = 'Pending';
                break;
              case 'Pending':
                status1 = 'Approve';
                break;
            }
            _updateStatusColor();
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          color: statusColor,
          child: Center(
            child: Text(
              'Status: $status1',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    ),
    SizedBox(width: 8),
    Expanded(
      child: Container(
      width: MediaQuery.of(context).size.width / 2 - 12, // Adjust width as needed
        height: 70, // Adjust height as needed
        child: GestureDetector(
        onTap: () {
  setState(() {
    switch (status2) {
      case 'Delivery':
        status2 = 'Prepare';
        break;
      case 'Prepare':
        status2 = 'Complete'; // Correct transition to 'Complete'
        break;
      case 'Complete':
        status2 = 'Delivery'; // Optionally cycle back to 'Delivery' or handle as needed
        break;
    }
    _updateDeliveryStatusColor();
  });
},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: deliveryStatusColor,
            child: Center(
              child: Text(
                'Delivery: $status2',
                style: TextStyle(color: Colors.white),
              ),
            ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}













































// 

// import 'dart:io';

// import 'package:bragasapps1/bragas_group/fetchDataAddToCart.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Fetch2database extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Combined Data Display'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             FetchAddToCart(),
//             FetchBuy(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FetchAddToCart extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             'CART Data',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//         StreamBuilder(
//           stream: FirebaseFirestore.instance.collection('CART').snapshots(),
//           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else {
//               List<DocumentSnapshot> documents = snapshot.data!.docs;
//               return ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: documents.length,
//                 itemBuilder: (context, index) {
//                   Map<String, dynamic>? data = documents[index].data() as Map<String, dynamic>?; // Explicit casting
//                   if (data != null) {
//                     return DataCard(data: data, onDelete: () {
//                       FirebaseFirestore.instance.collection('CART').doc(documents[index].id).delete();
//                     }, onUpdate: () {  },);
//                   } else {
//                     return SizedBox(); // Return an empty widget if data is null
//                   }
//                 },
//               );
//             }
//           },
//         ),
//       ],
//     );
//   }
// }

// class FetchBuy extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             'BUY Data',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//         StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance.collection('BUY').snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text('Error: ${snapshot.error}'),
//               );
//             }
//             final data = snapshot.data!;
//             return ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: data.size,
//               itemBuilder: (context, index) {
//                 final document = data.docs[index];
//                 return KaiDataItem(document: document);
//               },
//             );
//           },
//         ),
//       ],
//     );
//   }
// }












// class DataCard extends StatefulWidget {
//   final Map<String, dynamic> data;
//   final VoidCallback onDelete;
//   final VoidCallback onUpdate;

//   const DataCard({Key? key, required this.data, required this.onDelete, required this.onUpdate}) : super(key: key);

//   @override
//   _DataCardState createState() => _DataCardState();
// }

// class _DataCardState extends State<DataCard> {
//   int statusIndex = 0;
//   int deliveryStatusIndex = 0;

//   final List<String> statusOptions = ['Approve', 'Reject', 'Pending'];
//   final List<String> deliveryStatusOptions = ['Prepare', 'Delivery'];

//   final Map<String, Color> statusColors = {
//     'Approve': Colors.green,
//     'Reject': Colors.red,
//     'Pending': Colors.black,
//   };

//   final Map<String, Color> deliveryStatusColors = {
//     'Prepare': Colors.blue,
//     'Delivery': Colors.green,
//   };

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onLongPress: () async {
//         bool delete = await showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text('Delete Card?'),
//             content: Text('Are you sure you want to delete this card?'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(false);
//                 },
//                 child: Text('No'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(true);
//                 },
//                 child: Text('Yes'),
//               ),
//             ],
//           ),
//         );

//         if (delete != null && delete) {
//           widget.onDelete();
//         }
//       },
//       child: Card(
//         elevation: 3,
//         margin: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildImage(widget.data['selectedImage']),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text('User Data:', style: TextStyle(fontWeight: FontWeight.bold)),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Name: ${widget.data['userData']['name']}'),
//                   Text('Email: ${widget.data['userData']['email']}'),
//                   Text('Address: ${widget.data['userData']['address']}'),
//                   Text('Phone: ${widget.data['userData']['phone']}'),
//                   Text('Total Price: ${widget.data['totalPrice']}'),
//                 ],
//               ),
//             ),
//             SizedBox(height: 8),
//             Text('Products:', style: TextStyle(fontWeight: FontWeight.bold)),
//             ExpansionTile(
//               title: Text('Products'),
//               childrenPadding: EdgeInsets.symmetric(horizontal: 16),
//               children: [
//                 for (var product in widget.data['products']) ProductCard(product: product),
//               ],
//             ),
//             SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         statusIndex = (statusIndex + 1) % statusOptions.length;
//                       });
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       color: statusColors[statusOptions[statusIndex]],
//                       child: Center(
//                         child: Text(
//                           statusOptions[statusIndex],
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         deliveryStatusIndex = (deliveryStatusIndex + 1) % deliveryStatusOptions.length;
//                       });
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       color: deliveryStatusColors[deliveryStatusOptions[deliveryStatusIndex]],
//                       child: Center(
//                         child: Text(
//                           deliveryStatusOptions[deliveryStatusIndex],
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: widget.onUpdate,
//               child: Text('Update'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildImage(String? imagePath) {
//     if (imagePath != null && imagePath.isNotEmpty) {
//       if (imagePath.startsWith('http')) {
//         return Image.network(
//           imagePath,
//           width: 400,
//           height: 550,
//           fit: BoxFit.cover,
//         );
//       } else {
//         return Image.file(
//           File(imagePath),
//           width: 400,
//           height: 450,
//           fit: BoxFit.contain,
//         );
//       }
//     } else {
//       return SizedBox();
//     }
//   }
// }

// class ProductCard extends StatelessWidget {
//   final Map<String, dynamic> product;

//   const ProductCard({Key? key, required this.product}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Product Name: ${product['productName']}'),
//             Text('Quantity: ${product['quantity']}'),
//             Text('Selected Size: ${product['selectedSize']}'),
//             Text('Selected Price: ${product['selectedPrice']}'),
//             SizedBox(height: 8),
//             _buildProductImage(product['imagePath']),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProductImage(String? imagePath) {
//     if (imagePath != null && imagePath.isNotEmpty) {
//       if (imagePath.startsWith('http')) {
//         return Image.network(
//           imagePath,
//           width: 200,
//           height: 100,
//           fit: BoxFit.cover,
//         );
//       } else {
//         return Image.file(
//           File(imagePath),
//           width: 200,
//           height: 100,
//           fit: BoxFit.cover,
//         );
//       }
//     } else {
//       return SizedBox();
//     }
//   }
// }







// class KaiDataItem extends StatefulWidget {
//   final QueryDocumentSnapshot document;

//   const KaiDataItem({required this.document});

//   @override
//   _KaiDataItemState createState() => _KaiDataItemState();
// }

// class _KaiDataItemState extends State<KaiDataItem> {
//   String status = 'Pending';
//   String deliveryStatus = 'Delivery';
//   Color statusColor = Colors.black;
//   Color deliveryStatusColor = Colors.black;
  

//   void _updateStatusColor() {
//     setState(() {
//       switch (status) {
//         case 'Approve':
//           statusColor = Colors.green;
//           break;
//         case 'Reject':
//           statusColor = Colors.red;
//           break;
//         case 'Pending':
//           statusColor = Colors.black;
//           break;
//       }
//     });
//   }

//   void _updateDeliveryStatusColor() {
//     setState(() {
//       switch (deliveryStatus) {
//         case 'Delivery':
//           deliveryStatusColor = Colors.green;
//           break;
//         case 'Prepare':
//           deliveryStatusColor = Colors.blue;
//           break;
//       }
//     });
//   }

//   void _deleteData() async {
//     try {
//       await widget.document.reference.delete();
//     } catch (e) {
//       print('Error deleting document: $e');
//     }
//   }

//   void _updateData() async {
//     try {
//       await widget.document.reference.update({
//         'status': status,
//         'deliveryStatus': deliveryStatus,
//       });
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Data Updated Successfully'),
//         duration: Duration(seconds: 2),
//       ));
//     } catch (e) {
//       print('Error updating document: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final imagePath = widget.document['imagePath'];
//     final productName = widget.document['productName'];
//     final quantity = widget.document['quantity'];
//     final receiptPaymentImage = widget.document['receiptPaymentImage'];
//     final selectedPaymentType = widget.document['selectedPaymentType'];
//     final selectedPrice = widget.document['selectedPrice'];
//     final selectedSize = widget.document['selectedSize'];
//     final totalCost = widget.document['totalCost'];
//     final userAddress = widget.document['userAddress'];
//     final userEmail = widget.document['userEmail'];
//     final userName = widget.document['userName'];
//     final userPhone = widget.document['userPhone'];

//     // Display image if receiptPaymentImage is not null and not empty
//     Widget receiptImageWidget = SizedBox();
//     if (receiptPaymentImage != null && receiptPaymentImage.isNotEmpty) {
//       receiptImageWidget = Image.file(
//         File(receiptPaymentImage),
//         width: double.infinity,
//         height: 200,
//         fit: BoxFit.cover,
//       );
//     }

//     Widget imagePathWidget = SizedBox();
//     if (imagePath != null && imagePath.isNotEmpty) {
//       imagePathWidget = Image.file(
//         File(imagePath),
//         width: 100,
//         height: 100,
//         fit: BoxFit.cover,
//       );
//     }

//     return GestureDetector(
//       onLongPress: () {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Delete Card?'),
//               content: Text('Are you sure you want to delete this card?'),
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('Cancel'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     _deleteData();
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('Delete'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//       child: Card(
//         elevation: 3,
//         margin: EdgeInsets.all(8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (receiptImageWidget != SizedBox()) receiptImageWidget,
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   GestureDetector(
                  
//                     child: Container(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                     
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'User Email: $userEmail',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   Text(
//                     'Name: $userName',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   Text(
//                     'Address: $userAddress',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   Text(
//                     'Phone: $userPhone',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   Text(
//                     'Total Cost: $totalCost',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   Text(
//                     'Products:',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   ExpansionTile(
//                     title: Text('Products'),
//                     children: [
//                       Divider(),
//                       ListTile(
//                         title: Text(
//                           'Product Name: $productName',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                       ListTile(
//                         title: Text(
//                           'Quantity: $quantity',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                       ListTile(
//                         title: Text(
//                           'Selected Payment Type: $selectedPaymentType',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                       ListTile(
//                         title: Text(
//                           'Selected Price: $selectedPrice',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                       ListTile(
//                         title: Text(
//                           'Selected Size: $selectedSize',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                       if (imagePathWidget != SizedBox()) imagePathWidget,
//                     ],
//                   ),
//                   SizedBox(height: 8),
//         Row(
//   children: [
//     Container(
//          width: MediaQuery.of(context).size.width / 2 - 12, // Adjust width as needed
//       height: 70,  // Adjust height as needed
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             switch (status) {
//               case 'Approve':
//                 status = 'Reject';
//                 break;
//               case 'Reject':
//                 status = 'Pending';
//                 break;
//               case 'Pending':
//                 status = 'Approve';
//                 break;
//             }
//             _updateStatusColor();
//           });
//         },
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           color: statusColor,
//           child: Center(
//             child: Text(
//               'Status: $status',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//     ),
//     SizedBox(width: 8),
//     Expanded(
//       child: Container(
//       width: MediaQuery.of(context).size.width / 2 - 12, // Adjust width as needed
//         height: 70, // Adjust height as needed
//         child: GestureDetector(
//           onTap: () {
//             setState(() {
//               switch (deliveryStatus) {
//                 case 'Delivery':
//                   deliveryStatus = 'Prepare';
//                   break;
//                 case 'Prepare':
//                   deliveryStatus = 'Delivery';
//                   break;
//               }
//               _updateDeliveryStatusColor();
//             });
//           },
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//             color: deliveryStatusColor,
//             child: Center(
//               child: Text(
//                 'Delivery: $deliveryStatus',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//   ],
// ),


//                   SizedBox(height: 8),
//                   ElevatedButton(
//                     onPressed: _updateData,
//                     child: Text('Update'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
