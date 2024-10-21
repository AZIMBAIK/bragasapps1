import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProductCloth extends StatefulWidget {
  @override
  _AddProductClothState createState() => _AddProductClothState();
}

class _AddProductClothState extends State<AddProductCloth> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController limitController = TextEditingController();
  String? _selectedImagePath;
  List<Map<String, dynamic>> cartItems = [];

  void _addToCart() {
    if (priceController.text.isNotEmpty && sizeController.text.isNotEmpty && limitController.text.isNotEmpty) {
      cartItems.add({
        'price': int.parse(priceController.text),
        'size': sizeController.text,
        'limit': int.parse(limitController.text),
      });
      priceController.clear();
      sizeController.clear();
      limitController.clear();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item added to cart.')));
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields.')));
    }
  }

  void _registerProduct() {
    if (cartItems.isNotEmpty && productNameController.text.isNotEmpty && _selectedImagePath != null) {
      List<Map<String, dynamic>> details = cartItems.map((item) => {
        'size': item['size'], 'limit': item['limit'], 'price': item['price'],
      }).toList();
      _firestore.collection('products').add({
        'productName': productNameController.text,
        'imagePath': _selectedImagePath,
        'details': details,
        'timestamp': Timestamp.now(),
      }).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product registered successfully!'))))
          .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to register product. Please try again.'))));
      cartItems.clear();
      productNameController.clear();
      setState(() => _selectedImagePath = null);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cart is empty or missing product details.')));
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _selectedImagePath = pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Cloth', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                      image: _selectedImagePath != null ? DecorationImage(image: FileImage(File(_selectedImagePath!)), fit: BoxFit.cover) : null,
                    ),
                    child: _selectedImagePath == null ? Icon(Icons.add_photo_alternate, size: 50, color: Colors.grey[500]) : null,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: productNameController,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.tag),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.money_off),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: sizeController,
                  decoration: InputDecoration(
                    labelText: 'Size',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.format_size),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: limitController,
                  decoration: InputDecoration(
                    labelText: 'Limit',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.group_add),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    minimumSize: Size.fromHeight(50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: Text('Add to Cart'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _registerProduct,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    minimumSize: Size.fromHeight(50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: Text('Register Product'),
                ),
                SizedBox(height: 20),
                Text('Cart Items:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ...cartItems.map((item) => Card(
                  child: ListTile(
                    title: Text('Price: \$${item['price']}'),
                    subtitle: Text('Size: ${item['size']}, Limit: ${item['limit']}'),
                  ),
                )).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';


// // databse kena tukar produck change regProductCloth


// class AddProductCloth extends StatefulWidget {
//   @override
//   _AddProductClothState createState() =>
//       _AddProductClothState();
// }

// class _AddProductClothState extends State<AddProductCloth> {
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

//       _firestore.collection('products').add({
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
//         title: Text('Add Cloth',style: TextStyle(fontWeight: FontWeight.bold,)
//         ),
//      centerTitle: true, ),
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
