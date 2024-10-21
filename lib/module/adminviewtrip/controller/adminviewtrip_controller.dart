
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:bragasapps1/core.dart';
// import '../view/adminviewtrip_view.dart';

// class adminviewtripController extends State<adminViewTripform> {
//     static late adminviewtripController instance;
//     late adminViewTripform view;

//   var updateStatus;

 

//    adminviewtripController() {
//     instance = this;
//   }

//     @override
//     void initState() {
//         instance = this;
//         super.initState();
//     }

//     @override
//     void dispose() => super.dispose();

//     @override
//     Widget build(BuildContext context) => widget.build(context, this);

//    String? name;
//    String? address;
//    String? gender;
//    int? phone;
//    String? package;
//    String? resit;
//    String? status;
//   //  String?created_at;
//   //  String? owner_id;
//   //  String? user;

//    dosave() async {

//     // await FormRegsiterTrip_services().create(
//     //   name: name!,
//     //   address: address!,
//     //   gender: gender!,
//     //   phone: phone!,
//     //   package: package!,
//     //   resit: resit!,
//     //   status: status!,
//     await FirebaseFirestore.instance.collection("RegisterNow").add({
//       "name": name,
//       "address": address,
//       "gender": gender,
//       "phone": phone,
//       "package": package,
//       "resit": resit,
//       "status":status,
//       "created_at": Timestamp.now(),  
//      "user" :FirebaseAuth.instance.currentUser!.uid,
//     });

  
//   updatestatus1(Map<String, dynamic> item) async {
//   var status = item["status"];
//   if (status == "pending") {
//     status = "Approve";
//   } else if (status == "Approve") {
//     status = "Reject";
//   } else if (status == "Reject") {
//     status = "pending"; // Change to any other status as needed
//   }

//   await FirebaseFirestore.instance
//       .collection("RegisterNow")
//       .doc(item["id"])
//       .update({
//     "status": status,
//   });
// }


//     // await FirebaseFirestore.instance
//     // .collection("RegisterNow")
//     // .doc("id")
//     // .deletedata();

 
      
//     Get.back(); 
// }
// }

  
        
    