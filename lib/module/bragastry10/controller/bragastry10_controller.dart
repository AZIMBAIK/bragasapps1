import 'package:bragasapps1/module/bragastry10/view/bragastry10_view.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Bragastry10Controller extends GetxController {
  late Bragastry10View view;
  String? name;
  int? price ;
  String? photoUrl; // Assuming you have a field for storing photo URLs

  void saveData() async {
    try {
      // Get a reference to the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Add a new document with a generated ID
      await firestore.collection('products').add({
        'name': name,
        'Price': price,
        'photoUrl': photoUrl,
      });

      // Reset the form after saving
      name = null;
      price = 0;
      photoUrl = null;

      // Update the UI if needed
      view.update();

      // Show a success message using snackbar if Get context is available
      if (Get.isSnackbarOpen != true) {
        Get.snackbar('Success', 'Data saved to Firestore');
      }
    } catch (e) {
      // Handle any errors that occur during the process
      print('Error saving data: $e');
      // Show an error message using snackbar if Get context is available
      if (Get.isSnackbarOpen != true) {
        Get.snackbar('Error', 'Failed to save data');
      }
    }
  }
}
