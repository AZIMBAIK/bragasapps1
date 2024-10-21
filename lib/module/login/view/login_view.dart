
  import 'package:flutter/material.dart';
  import '../controller/login_controller.dart';
  import 'package:bragasapps1/core.dart';
  import 'package:get/get.dart';
  
  class LoginView extends StatelessWidget {
    const LoginView({Key? key}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          controller.view = this;
  
          return Scaffold(
            appBar: AppBar(
              title: const Text("Login"),
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
    