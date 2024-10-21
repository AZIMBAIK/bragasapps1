// import 'package:bragasapps1/shoopingAll/resitBaju.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class orderHistoryTry extends StatefulWidget {
//   @override
//   _orderHistoryTryState createState() => _orderHistoryTryState();
// }

// class _orderHistoryTryState extends State<orderHistoryTry> {
//   get item => null;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('All Receipts'),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('order').snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           }

//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }

//           List<ReceiptDetails> receipts = snapshot.data!.docs.map((document) {
//             Map<String, dynamic> data =
//                 document.data() as Map<String, dynamic>;
//             return ReceiptDetails(
//               orderId: document.id,
//               address: data['address'],
//               status: data['status'],
   
//               orderDetails: List<Map<String, dynamic>>.from(
//                 data['orderDetails'],
//               ), assetPath: data,
//             );
//           }).toList();

//           return ListView.builder(
//             itemCount: receipts.length,
//             itemBuilder: (context, index) {
//               return Card(
//                 margin: EdgeInsets.all(10.0),
//                 child: ListTile(
//                   title: Text('Order ID: ${receipts[index].orderId}'),
//                   subtitle: Text('Address: ${receipts[index].address}\nStatus: ${receipts[index].status}'),
//                   leading: CircleAvatar(
//                       // backgroundColor: Colors.grey[200],
//                       backgroundImage: NetworkImage(
//                         item["resit"] , // Null check for image URL
//                       ),
//                     ),
                
//                   onTap: () {
//                     // Navigate to a detailed receipt view
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DetailedReceiptPage(receipt: receipts[index]),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }