
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bragasapps1/core.dart';
import '../view/registertrip_form5_view.dart';

class bragas2conttroller extends State<RegistertripForm5View> {
    static late bragas2conttroller instance;
    late RegistertripForm5View view;

     bragas2conttroller() {
    instance = this;
  }

    @override
    void initState() {
        instance = this;
        super.initState();
    }

    @override
    void dispose() => super.dispose();

    @override
   Widget build(BuildContext context) => widget.build(context, this);

   String? name;
   String? address;
   String? gender;
   int? phone;
   String? package;
   String? resit;
   String?status;
  //  String?created_at;
  //  String? owner_id;
  //  String? user;

   dosave() async {

    await FirebaseFirestore.instance.collection("registerNow").add({
      "name": name,
      "address": address,
      "gender": gender,
      "phone": phone,
      "package": package,
      "resit": resit,
      "status":status,
      "created_at": Timestamp.now(),  
     "user" :FirebaseAuth.instance.currentUser!.uid,
    });


    updateStatus(Map<String,dynamic>item) async {
      
      await FirebaseFirestore.instance
      .collection("registerNow")
      .doc("xxx")
      .update({
      "status": "status",
     
      });
    }

 


      
    Get.back(); 
}
}       
    