
  import 'package:flutter/material.dart';
  import '../controller/register_controller.dart';
  import 'package:bragasapps1/core.dart';
  import 'package:get/get.dart';
  
  class RegisterView extends StatelessWidget {
    const RegisterView({Key? key}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (controller) {
          controller.view = this;
  
          return Scaffold(
            appBar: AppBar(
              title: const Text("Register"),
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
    