
  import 'package:flutter/material.dart';
  import '../controller/adminlogin1_controller.dart';
  import 'package:bragasapps1/core.dart';
  import 'package:get/get.dart';
  
  class Adminlogin1View extends StatelessWidget {
    const Adminlogin1View({Key? key}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return GetBuilder<Adminlogin1Controller>(
        init: Adminlogin1Controller(),
        builder: (controller) {
          controller.view = this;
  
          return Scaffold(
            appBar: AppBar(
              title: const Text("Adminlogin1"),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: const [],
                ),
              ),
            ),
          );
        },
      );
    }
  }
    