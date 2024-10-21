// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class ViewBooking extends StatefulWidget {
//   const ViewBooking({Key? key}) : super(key: key);

//   @override
//   State<ViewBooking> createState() => _ViewBookingState();
// }

// class _ViewBookingState extends State<ViewBooking> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const  Text(
//       // "Booking Trip",
//       // style: TextStyle(
//       //   fontWeight: FontWeight.bold,
//       // ),
//       //   ),
//       //   actions: const [],
//       // ),
//       body: Container(
//         padding: const EdgeInsets.all(20.0),
//         child: Expanded(
//           child: Column(
//             children: [
//               StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance.collection("registerform").snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) return const Text("Error");
//                   if (snapshot.data == null) {// return const Center(child: CircularProgressIndicator()); // Show loader while data is loading
//                   return Container();
//                   }
//                   if (snapshot.data!.docs.isEmpty) {
//                     return const Text("No Data");
//                   }

//                   final data = snapshot.data!;
//                   return ListView.builder(
//                     itemCount: data.docs.length,
//                     shrinkWrap: true,
//                     padding: EdgeInsets.zero,
//                     itemBuilder: (context, index) {
//                       Map<String, dynamic> item = 
//                       (data.docs[index].data() as Map<String, dynamic>);
//                       item["id"] = data.docs[index].id;

//                       return Card(
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             backgroundColor: Colors.grey[200],
//                             backgroundImage:  NetworkImage(
//                               item["resit"],
//                             ),
//                           ),
//                           title: Text(item["product_name"] ?? ""),
//                           subtitle: Text(item["package"] ?? ""),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


