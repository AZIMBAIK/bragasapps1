
  import 'package:flutter/material.dart';
  import '../controller/adminlogin2_controller.dart';
  import 'package:bragasapps1/core.dart';
  import 'package:get/get.dart';
  
  class Adminlogin2View extends StatelessWidget {
    const Adminlogin2View({Key? key}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return GetBuilder<Adminlogin2Controller>(
        init: Adminlogin2Controller(),
        builder: (controller) {
          controller.view = this;
  
          return Scaffold(
            appBar: AppBar(
              title: const Text("Adminlogin2"),
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
    