
import 'package:flutter/material.dart';
import 'package:bragasapps1/core.dart';
import '../controller/kasut2_controller.dart';

class Kasut2View extends StatefulWidget {
  const Kasut2View({Key? key}) : super(key: key);

  Widget build(context, Kasut2Controller controller) {
  controller.view = this;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kasut2"),
        actions: const [],
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
  }

  @override
  State<Kasut2View> createState() => Kasut2Controller();
}
    