// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AddProductShoes extends StatefulWidget {
//   @override
//   _AddProductShoesState createState() =>
//       _AddProductShoesState();
// }

// class _AddProductShoesState extends State<AddProductShoes> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   TextEditingController productNameController = TextEditingController();
//   TextEditingController priceController = TextEditingController();
//   TextEditingController sizeController = TextEditingController();
//   TextEditingController limitController = TextEditingController();
//   String? _selectedImagePath;
//   List<Map<String, dynamic>> cartItems = []; // List to store cart items

//   void _addToCart() {
//     if (priceController.text.isNotEmpty &&
//         sizeController.text.isNotEmpty &&
//         limitController.text.isNotEmpty) {
//       cartItems.add({
//         'price': int.parse(priceController.text),
//         'size': sizeController.text,
//         'limit': int.parse(limitController.text),
//       });
//       // Clear the input fields
//       priceController.clear();
//       sizeController.clear();
//       limitController.clear();
//       // Update UI
//       setState(() {});
//       // Show success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Item added to cart.'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please fill all fields.'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   void _registerProduct() {
//     if (cartItems.isNotEmpty &&
//         productNameController.text.isNotEmpty &&
//         _selectedImagePath != null) {
//       List<Map<String, dynamic>> details = cartItems.map((item) {
//         return {
//           'size': item['size'],
//           'limit': item['limit'],
//           'price': item['price'],
//         };
//       }).toList();

//       _firestore.collection('RegProductShoes').add({
//         'productName': productNameController.text,
//         'imagePath': _selectedImagePath,
//         'details': details,
//         'timestamp': Timestamp.now(),
//       }).then((value) {
//         // Show success message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Product registered successfully!'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//         // Clear cart items, product name, and image path
//         cartItems.clear();
//         productNameController.clear();
//         setState(() {
//           _selectedImagePath = null;
//         });
//       }).catchError((error) {
//         // Show error message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to register product. Please try again.'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Cart is empty or missing product details.'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _selectedImagePath = pickedFile.path;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(' Registration Shoes'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTap: _pickImage,
//               child: Container(
//                 width: 100,
//                 height: 100,
//                 decoration: BoxDecoration(
//                   border: Border.all(width: 1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: _selectedImagePath != null
//                     ? Image.file(
//                         File(_selectedImagePath!),
//                         fit: BoxFit.cover,
//                       )
//                     : Icon(Icons.add_photo_alternate),
//               ),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: productNameController,
//               decoration: InputDecoration(labelText: 'Product Name'),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: priceController,
//               decoration: InputDecoration(labelText: 'Price'),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: sizeController,
//               decoration: InputDecoration(labelText: 'Size'),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: limitController,
//               decoration: InputDecoration(labelText: 'Limit'),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _addToCart, // Add to cart button
//               child: Text('Add to Cart'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _registerProduct, // Register product button
//               child: Text('Register Product'),
//             ),
//             SizedBox(height: 16),
//             // Display cart items
//             Text('Cart Items:'),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: cartItems.length,
//                 itemBuilder: (context, index) {
//                   final item = cartItems[index];
//                   return ListTile(
//                     title: Text('Price: \$${item['price']}'),
//                     subtitle: Text('Size: ${item['size']}, Limit: ${item['limit']}'),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }











import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProductShoes extends StatefulWidget {
  @override
  _AddProductShoesState createState() => _AddProductShoesState();
}

class _AddProductShoesState extends State<AddProductShoes> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController limitController = TextEditingController();
  String? _selectedImagePath;
  List<Map<String, dynamic>> cartItems = [];

  void _addToCart() {
    if (priceController.text.isNotEmpty &&
        sizeController.text.isNotEmpty &&
        limitController.text.isNotEmpty) {
      cartItems.add({
        'price': int.parse(priceController.text),
        'size': sizeController.text,
        'limit': int.parse(limitController.text),
      });
      priceController.clear();
      sizeController.clear();
      limitController.clear();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item added to cart.'), duration: Duration(seconds: 2)));
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields.'), duration: Duration(seconds: 2)));
    }
  }

  void _registerProduct() {
    if (cartItems.isNotEmpty && productNameController.text.isNotEmpty && _selectedImagePath != null) {
      List<Map<String, dynamic>> details = cartItems.map((item) => {'size': item['size'], 'limit': item['limit'], 'price': item['price']}).toList();
      _firestore.collection('RegProductShoes').add({
        'productName': productNameController.text,
        'imagePath': _selectedImagePath,
        'details': details,
        'timestamp': Timestamp.now(),
      }).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product registered successfully!'), duration: Duration(seconds: 2))))
          .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to register product. Please try again.'), duration: Duration(seconds: 2))));
      cartItems.clear();
      productNameController.clear();
      setState(() {
        _selectedImagePath = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cart is empty or missing product details.'), duration: Duration(seconds: 2)));
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Shoes', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,)),
        backgroundColor: Colors.deepPurple,
      centerTitle: true,),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Card(
          elevation: 4,
          shadowColor: Colors.deepPurple.withOpacity(0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.deepPurple.shade50,
                    ),
                    child: _selectedImagePath != null ? Image.file(File(_selectedImagePath!), fit: BoxFit.cover) : Icon(Icons.camera_alt, color: Colors.deepPurple, size: 50),
                  ),
                ),
                SizedBox(height: 20),
                buildTextField('Product Name', productNameController, Icons.label_outline),
                buildTextField('Price', priceController, Icons.attach_money, isNumber: true),
                buildTextField('Size', sizeController, Icons.straighten),
                buildTextField('Limit', limitController, Icons.people, isNumber: true),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text('Add to Cart', style: TextStyle( color: Colors.white,fontSize: 16)),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _registerProduct,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text('Register Product', style: TextStyle(fontSize: 16)),
                ),
                SizedBox(height: 20),
                Text('Cart Items:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return ListTile(
                      title: Text('Price: \$${item['price']}'),
                      subtitle: Text('Size: ${item['size']}, Limit: ${item['limit']}'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, IconData icon, {bool isNumber = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      ),
    );
  }
}
