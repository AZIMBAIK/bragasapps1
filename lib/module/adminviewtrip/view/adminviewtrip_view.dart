
// import 'package:bragasapps1/module/adminviewtrip/controller/adminviewtrip_controller.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:bragasapps1/core.dart';
// import '../controller/adminviewtrip_controller.dart';

// class adminViewTripform extends StatefulWidget {
//   const adminViewTripform({Key? key}) : super(key: key);

//   Widget build(context, adminviewtripController controller) {
//   controller.view = this;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Booking Trip",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: const [],
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(20.0),
//         child: StreamBuilder<QuerySnapshot>(
//           stream:
//               FirebaseFirestore.instance.collection("RegisterNow").snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) return const Text("Error");
//             if (!snapshot.hasData) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             final data = snapshot.requireData;

//             if (data.docs.isEmpty) {
//               return const Text("No Data");
//             }

//             return ListView.builder(
//               itemCount: data.docs.length,
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 Map<String, dynamic> item =
//                     (data.docs[index].data() as Map<String, dynamic>);
//                 item["id"] = data.docs[index].id;
//                 var createdAt = item["created_at"];
//                 var date = (createdAt as Timestamp).toDate();

//                 Color? color = Colors.black;
//                 String status = item["status"] ?? ""; // Null check for status

//                 if (status == "pending") {
//                   color = Colors.yellow;
//                 } else if (status == "Approve") {
//                   color = const Color.fromARGB(255, 5, 218, 12);
//                 } else if (status == "Reject") {
//                   color = Colors.red;
//                 }

               
          
//                 return Card(
//                   child: ListTile(
//                     // onTap: () => controller.updatestatus1[item],
//                     onTap: () =>controller.updateStatus[item],
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.grey[200],
//                       backgroundImage: NetworkImage(
//                         item["resit"] , // Null check for image URL
//                       ),
//                     ),
//                     title: Text(item["name"] ), // Null check for name
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(item["package"]), // Null check for package
//                         SizedBox(height: 4),
//                         Text("$date"),
//                         Text("$status)",
//                         style: TextStyle(color: color,),),
//                       ],
//                     ),
//                     trailing: IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () {
//                         // controller.deleteData(item["id"]);
//                       },
//                     ),
//                     //  trailing: Text(item["status"],
//                     //  style: TextStyle(
//                     //   fontSize: 16,
//                     //   color: color,
//                     //  ),),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
  
//   @override
// State<adminViewTripform> createState() => adminviewtripController();
//   }
  
  


 



    