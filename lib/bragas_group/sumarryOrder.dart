// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class SummaryOrder extends StatefulWidget {
//   @override
//   _SummaryOrderState createState() => _SummaryOrderState();
// }

// class _SummaryOrderState extends State<SummaryOrder> {
//   late Future<List<DocumentSnapshot>> clothProducts;
//   double totalPrice = 0.0;

//   late User? _currentUser;
//   Map<String, dynamic>? _userData;

//   @override
//   void initState() {
//     super.initState();
//     _currentUser = FirebaseAuth.instance.currentUser;
//     if (_currentUser != null) {
//       fetchUserData(_currentUser!.uid);
//     }
//     clothProducts = fetchClothProducts();
//   }

//   Future<List<DocumentSnapshot>> fetchClothProducts() async {
//     QuerySnapshot querySnapshot =
//         await FirebaseFirestore.instance.collection('cloth_product_add_to_cart').get();
//     return querySnapshot.docs;
//   }

//   Future<void> deleteProduct(String productId) async {
//     await FirebaseFirestore.instance.collection('cloth_product_add_to_cart').doc(productId).delete();
//     // Refresh data after deletion
//     setState(() {
//       clothProducts = fetchClothProducts();
//     });
//   }

//   Future<void> fetchUserData(String userId) async {
//     try {
//       DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(userId)
//           .get();

//       if (userSnapshot.exists) {
//         setState(() {
//           _userData = userSnapshot.data() as Map<String, dynamic>?;
//         });
//       }
//     } catch (e) {
//       print('Error fetching user data: $e');
//     }
//   }

//   void editPhone() {
//     // Add your code to handle editing phone number
//     print('Edit Phone');
//   }

//   void editAddress() {
//     // Add your code to handle editing address
//     print('Edit Address');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order Summary'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Card for user information
//             Card(
//               margin: EdgeInsets.all(16),
//               elevation: 2,
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'User Information:',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     if (_userData != null) ...[
//                       SizedBox(height: 12),
//                       Text('Name: ${_userData!['name']}'),
//                       SizedBox(height: 8),
//                       Text('Email: ${_userData!['email']}'),
//                       SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Text('Address: ${_userData!['address']}'),
//                           SizedBox(width: 8),
//                           IconButton(
//                             onPressed: editAddress,
//                             icon: Icon(Icons.edit),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Text('Phone: ${_userData!['phone']}'),
//                           SizedBox(width: 8),
//                           IconButton(
//                             onPressed: editPhone,
//                             icon: Icon(Icons.edit),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8),
//                       Text('UID: ${_userData!['uid']}'),
//                     ],
//                   ],
//                 ),
//               ),
//             ),
//             // Product List
//             FutureBuilder<List<DocumentSnapshot>>(
//               future: clothProducts,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No cloth products available.'));
//                 } else {
//                   List<DocumentSnapshot> products = snapshot.data!;
//                   totalPrice = 0.0; // Reset total price

//                   for (var product in products) {
//                     Map<String, dynamic> productData = product.data() as Map<String, dynamic>;
//                     double price = double.parse(productData['selectedPrice'].toString());
//                     int quantity = int.parse(productData['quantity'].toString());
//                     totalPrice += price * quantity;
//                   }

//                   return ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(), // Disable list scrolling
//                     itemCount: products.length,
//                     itemBuilder: (context, index) {
//                       Map<String, dynamic> productData = products[index].data() as Map<String, dynamic>;
//                       String imagePath = productData['imagePath'] ?? '';

//                       Widget imageWidget;
//                       if (imagePath.startsWith('http')) {
//                         imageWidget = Image.network(
//                           imagePath,
//                           width: 200,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         );
//                       } else {
//                         imageWidget = Image.file(
//                           File(imagePath),
//                           width: 170,
//                           height: 140,
//                           fit: BoxFit.cover,
//                         );
//                       }

//                       return Container(
//                         width: 400,
//                         height: 200,
//                         child: Card(
//                           elevation: 2,
//                           margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               imageWidget,
//                               SizedBox(width: 16),
//                               Expanded(
//                                 child: Padding(
//                                   padding: EdgeInsets.all(12),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         ' ${productData['productName']}',
//                                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                                       ),
//                                       SizedBox(height: 2),
//                                       Text(
                                       
//                                       'Size: ${productData['selectedSize']}',
//                                         style: TextStyle(fontSize: 16),
//                                       ),
//                                       SizedBox(height: 2),
//                                       Text(
//                                         ' \RM${productData['selectedPrice']}',
//                                         style: TextStyle(fontSize: 16),
//                                       ),
//                                       SizedBox(height: 2),
//                                       Text(
//                                         'Quantity: ${productData['quantity']}',
//                                         style: TextStyle(fontSize: 16),
//                                       ),
//                                       SizedBox(height: 8),
//                                       ElevatedButton(
//                                         onPressed: () {
//                                           deleteProduct(products[index].id);
//                                         },
//                                         style: ElevatedButton.styleFrom(
//                                           backgroundColor: Colors.red,
//                                           minimumSize: Size(100, 36),
//                                         ),
//                                         child: Text('Delete'),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//             // Total Price Container
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               color: Colors.grey[300],
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Total Price: \$${totalPrice.toStringAsFixed(2)}',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   // Add Buy Now button or any other widgets here if needed
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// //V3