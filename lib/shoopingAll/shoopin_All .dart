// import 'package:bragasapps1/core.dart';
// import 'package:bragasapps1/maping_All.dart';
// import 'package:bragasapps1/shoopingAll/kasut.dart';


// import 'package:carousel_slider/carousel_slider.dart';

// import 'package:flutter/material.dart';
// import 'package:bragasapps1/shoopingAll/baju.dart'; // Import your necessary files/modules here


// class shoopingALL extends StatefulWidget {
//   @override
//   State<shoopingALL> createState() => _shoopingALLState();

// }

// class _shoopingALLState extends State<shoopingALL> {
//   ShoppingData productController = ShoppingData();
//   Textdata productController1 = Textdata();


//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//        title: Text("BRAGAS SHOP",style: TextStyle(fontWeight: FontWeight.bold,),),
//       centerTitle: true,
//       backgroundColor: Colors.yellow,
       
     
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             children: [
//               Container(
//                 height: 180.0,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage(
//                       "https://media.istockphoto.com/id/1451538143/photo/flash-sale-neon-sign.jpg?s=1024x1024&w=is&k=20&c=4v_YI367Y2ZfqPYJdKVJJg2bt3krZSUdkAQxFnXAP_U=",
//                     ),
//                     fit: BoxFit.cover,
//                   ),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(16.0),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30.0),


//               GridView.builder(
//                 padding: EdgeInsets.zero,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   childAspectRatio: 1.0 / 0.3,
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 2,
//                   crossAxisSpacing: 2,
//                 ),
//                 shrinkWrap: true,
//                 itemCount: productController1.Text1.length, // Using textList from ProductController
//                 physics: const ScrollPhysics(),
//                 itemBuilder: (BuildContext context, int index) {
//                   var item = productController1.Text1[index];

//                   return GestureDetector(
//                     onTap: () {
//                       // Navigate to the desired screen when the container is tapped
//                       switch (index) {
//                         case 0: // Change the index based on your navigation logic
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => baju(),
//                             ),
//                           );
//                           case 1:
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => Kasut()),
//                             );
//                             break;
//                         }
//                         // Add more cases for other navigations
                      
//                     },
//                     child:  Container(
//   decoration: BoxDecoration(
//     color: Colors.black87,
//     borderRadius: BorderRadius.circular(15.0),
//     boxShadow: [
//       BoxShadow(
//         color: Colors.black.withOpacity(0.3),
//         spreadRadius: 1,
//         blurRadius: 10,
//         offset: const Offset(0, 3),
//       ),
//     ],
//   ),
//   child: Row(
//     children: [
//       Expanded(
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Text(
//             item,
//             style: const TextStyle(
//               fontSize: 25.0,
//               color: Colors.white70,
//             ),
//           ),
//         ),
//       ),
//       const Icon(
//         Icons.chevron_right_rounded,
//         size: 30.0,
//         color: Colors.white70,
//       ),
//     ],
//   ),
// ),

//                   );
//                 },
//               ),
//               SizedBox(height: 30,),

//                    Builder(builder: (context) {
//                     List images = [
//                       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdJS-WVL091ArpPdC8GwgLIOCkSYNwGfwEwA&usqp=CAU",
//                       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfyEfSyol5sXD3vQKNExdnHxsxlSUKSzm6fg&usqp=CAU",
//                       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3XbsuPYeuSzwd0snh0Pkli9LTGC6A1IvSxw&usqp=CAU",
//                       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUVW9xCB2ToTKlW-k-iaEilLPKThDkSVcfjw&usqp=CAU",
//                     ];

//                     return CarouselSlider(
//                       options: CarouselOptions(
//                         height: 300.0,
//                         autoPlay: true,
//                         enlargeCenterPage: true,
//                       ),
//                       items: images.map((imageUrl) {
//                         return Builder(
//                           builder: (BuildContext context) {
//                             return Container(
//                               width: MediaQuery.of(context).size.width,
//                               margin:
//                                   const EdgeInsets.symmetric(horizontal: 5.0),
//                               decoration: BoxDecoration(
//                                 color: Colors.amber,
//                                 borderRadius: const BorderRadius.all(
//                                   Radius.circular(16.0),
//                                 ),
//                                 image: DecorationImage(
//                                   image: NetworkImage(
//                                     imageUrl,
//                                   ),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       }).toList(),
//                     );
//                   }),
              
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }










// // class orderHistory extends StatefulWidget {
// //   @override
// //   _orderHistoryState createState() => _orderHistoryState();
// // }

// // class _orderHistoryState extends State<orderHistory> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('All Receipts'),
// //       ),
// //       body: StreamBuilder(
// //         stream: FirebaseFirestore.instance.collection('orders').snapshots(),
// //         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return CircularProgressIndicator();
// //           }

// //           if (snapshot.hasError) {
// //             return Text('Error: ${snapshot.error}');
// //           }

// //           List<ReceiptDetails> receipts = snapshot.data!.docs.map((document) {
// //             Map<String, dynamic> data =
// //                 document.data() as Map<String, dynamic>;
// //             return ReceiptDetails(
// //               orderId: document.id,
// //               address: data['address'],
// //               status: data['status'],
// //               orderDetails: List<Map<String, dynamic>>.from(
// //                 data['orderDetails'],
// //               ),
// //             );
// //           }).toList();

// //           return ListView.builder(
// //             itemCount: receipts.length,
// //             itemBuilder: (context, index) {
// //               return Card(
// //                 margin: EdgeInsets.all(10.0),
// //                 child: ListTile(
// //                   title: Text('Order ID: ${receipts[index].orderId}'),
// //                   subtitle: Text('Address: ${receipts[index].address}\nStatus: ${receipts[index].status}'),
                
// //                   onTap: () {
// //                     // Navigate to a detailed receipt view
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (context) => DetailedReceiptPage(receipt: receipts[index]),
// //                       ),
// //                     );
// //                   },
// //                 ),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }