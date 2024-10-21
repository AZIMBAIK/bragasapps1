
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:flutter/material.dart';
// import 'package:bragasapps1/core.dart';


// class FormRegsiterTrip_services extends State<RegistertripForm5View> {
//     static late FormRegsiterTrip_services instance;
//     late RegistertripForm5View view;

//      FormRegsiterTrip_services() {
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
//    Widget build(BuildContext context) => widget.build(context, this as RegistertripForm5Controller);

//   //  String? name;
//   //  String? address;
//   //  String? gender;
//    int? calculateTotalPrice;
//    int? calculateTotalQuantity;
//   //  String? package;
//   //  String? resit;
//   //  String?status;
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
//     await FirebaseFirestore.instance.collection("shooping now").add({
//     //   "name": name,
//     //   "address": address,
//     //   "gender": gender,
//     //   "phone": phone,
//     //   "package": package,
//     //   "resit": resit,
//     //   "status":status,
//     //   "created_at": Timestamp.now(),  
//     //  "user" :FirebaseAuth.instance.currentUser!.uid,

//   "calculateTotalPrice": calculateTotalPrice,
//   "calculateTotalQuantity":calculateTotalQuantity
//     });
      
//     Get.back(); 
// }
// }       
    