import 'package:bragasapps1/reusableWIdget/QImagePicker.dart';
import 'package:bragasapps1/reusableWIdget/QTextField.dart';
import 'package:bragasapps1/reusableWIdget/Validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/bragastry10_controller.dart';


class Bragastry10View extends StatelessWidget {
  const Bragastry10View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Bragastry10Controller controller = Get.put(Bragastry10Controller());

    return GetBuilder<Bragastry10Controller>(
      init: controller,
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Bragastry10"),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  QImagePicker(
                    label: "Photo",
                    validator: Validator.required,
                    // value: null,
                    onChanged: (value) {
                      controller.photoUrl = value;
                    },
                  ),
                  QTextField(
                    label: "Name",
                    validator: Validator.required,
                    value: null,
                    onChanged: (value) {
                      controller.name = value;
                    },
                  ),
                  QTextField(
                    label: "Price",
                    validator: Validator.required,
                    value: null,
                    onChanged: (value) {
                      controller.price = int.tryParse(value) ?? 0;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Save data to Firestore
                      controller.saveData();
                    },
                    child: Text('Save Data'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void update() {}
}
