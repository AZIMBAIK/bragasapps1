
// //2
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class AddToCartShoes extends StatefulWidget {
//   final Map<String, dynamic> productData;

//   AddToCartShoes({required this.productData});
//   @override
//   _AddToCartShoesState createState() => _AddToCartShoesState();
// }

// class _AddToCartShoesState extends State<AddToCartShoes> {
//   late Future<List<DocumentSnapshot>> clothProducts;
//   double totalPrice = 0.0;
//   int totalOrders = 0; // Total number of orders
//   double shippingCost = 0.0; // Shipping cost per order
//   late User _user; // Firebase User object
//   late Map<String, dynamic> _userData; // User data
//   String? dropdownValue; // Dropdown value
//   File? _selectedImage; // Selected image

//   @override
//   void initState() {
//     super.initState();
//     _user = FirebaseAuth.instance.currentUser!; // Get current user
//     _userData = {}; // Initialize user data map
//     fetchUserData(); // Fetch user data
//     clothProducts = fetchClothProducts();
//   }

//   Future<void> fetchUserData() async {
//     DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(_user.uid) // Assuming you store user data under 'users' collection with UID as document ID
//         .get();

//     if (userSnapshot.exists) {
//       setState(() {
//         _userData = userSnapshot.data() as Map<String, dynamic>;
//       });
//     } else {
//       // User data not found, handle this case (e.g., show blank page)
//       print('User data not found.');
//       // You can set _userData to an empty map or handle it based on your UI requirements
//       setState(() {
//         _userData = {};
//       });
//     }
//   }

//   Future<List<DocumentSnapshot>> fetchClothProducts() async {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('cloth_product_add_to_cart')
//         .where('uid', isEqualTo: _user.uid) // Fetch products only for the current user
//         .get();
//     return querySnapshot.docs;
//   }

//   Future<void> deleteProduct(String productId) async {
//     await FirebaseFirestore.instance.collection('Shoes_product_add_to_cart').doc(productId).delete();
//     // Refresh data after deletion
//     setState(() {
//       clothProducts = fetchClothProducts();
//     });
//   }

//   void editAddress() {
//     // Implement edit address functionality
//   }

//   void editPhone() {
//     // Implement edit phone functionality
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add to cart product'),
//       ),
//       body: FutureBuilder<List<DocumentSnapshot>>(
//         future: clothProducts,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No cloth products available.'));
//           } else {
//             List<DocumentSnapshot> products = snapshot.data!;
//             totalPrice = 0.0; // Reset total price
//             totalOrders = products.length; // Update total orders
//             shippingCost = totalOrders * 4.0; // Calculate shipping cost

//             // Calculate total price
//             for (var product in products) {
//               Map<String, dynamic> productData = product.data() as Map<String, dynamic>;
//               double price = double.parse(productData['selectedPrice'].toString());
//               int quantity = int.parse(productData['quantity'].toString());
//               totalPrice += price * quantity;
//             }

//             // Calculate total price with shipping
//             double totalPriceWithShipping = totalPrice + shippingCost;

//             return SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   UserInfoCard(userData: _userData),
//                   DropdownCard(
//                     dropdownValue: dropdownValue,
//                     onValueChanged: (value) {
//                       setState(() {
//                         dropdownValue = value;
//                       });
//                     },
//                     onImageSelected: (image) {
//                       // Set selected image
//                       setState(() {
//                         _selectedImage = image;
//                       });
//                     },
//                   ),
//                   ProductList(
//                     products: products,
//                     deleteProduct: deleteProduct,
//                   ),
//                   TotalPriceCard(
//                     totalPrice: totalPriceWithShipping,
//                     shippingCost: shippingCost,
//                     clothProducts: products,
//                     userData: _userData,
//                     dropdownValue: dropdownValue,
//                     context: context,
//                     selectedImage: _selectedImage,
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class UserInfoCard extends StatelessWidget {
//   final Map<String, dynamic> userData;

//   const UserInfoCard({Key? key, required this.userData}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(16),
//       elevation: 2,
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'User Information:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 12),
//             Text('Name: ${userData['name']}'),
//             SizedBox(height: 8),
//             Text('Email: ${userData['email']}'),
//             SizedBox(height: 8),
//             Text('Address: ${userData['address']}'),
//             SizedBox(height: 8),
//             Text('Phone: ${userData['phone']}'),
//             SizedBox(height: 8),
//             Text('UID: ${FirebaseAuth.instance.currentUser!.uid}'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DropdownCard extends StatefulWidget {
//   final String? dropdownValue;
//   final Function(String?)? onValueChanged;
//   final Function(File)? onImageSelected; // Add this line

//   const DropdownCard({Key? key, this.dropdownValue, this.onValueChanged, this.onImageSelected}) : super(key: key);

//   @override
//   _DropdownCardState createState() => _DropdownCardState();
// }
// class _DropdownCardState extends State<DropdownCard> {
//   String? accountNumber;
//   File? _selectedImage;

//   void updateAccountNumber(String? bank) {
//     // Update account number based on bank selection
//     if (bank == 'MAYBANK') {
//       accountNumber = '2345';
//     } else if (bank == 'CIMBBANK') {
//       accountNumber = '12345';
//     } else if (bank == 'RHBBANK') {
//       accountNumber = '5789';
//     } else if (bank == 'ISLAMIC BANK') {
//       accountNumber = '4789';
//     } else {
//       accountNumber = null; // Handle other cases if needed
//     }
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage = File(pickedImage.path);
//       });
//       widget.onImageSelected?.call(_selectedImage!); // Notify parent widget of selected image
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     updateAccountNumber(widget.dropdownValue);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(16),
//       elevation: 2,
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'SELECT PAYMENT TYPE:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 12),
//             DropdownButton<String>(
//               value: widget.dropdownValue,
//               items: <String>['MAYBANK', 'CIMBBANK', 'RHBBANK', 'ISLAMIC BANK']
//                   .map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               onChanged: (newValue) {
//                 // Update the account number and notify the parent widget of the value change
//                 updateAccountNumber(newValue);
//                 widget.onValueChanged?.call(newValue);
//               },
//             ),
//             SizedBox(height: 12),
//             Text(
//               'Account Number: $accountNumber',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 12),
//             _buildImagePickerButton(), // Changed to image picker button
//             SizedBox(height: 16),
//             _selectedImage != null ? _buildImagePreview() : Container(), // Display the selected image
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildImagePickerButton() {
//     return ElevatedButton.icon(
//       onPressed: _pickImage,
//       icon: Icon(Icons.image), // Icon for image picker
//       label: Text('Pick Image'),
//       style: ElevatedButton.styleFrom(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0), // Adjust border radius as needed
//         ),
//       ),
//     );
//   }

//   Widget _buildImagePreview() {
//     return Image.file(
//       _selectedImage!,
//       width: 200,
//       height: 100,
//       fit: BoxFit.cover,
//     );
//   }
// }

// class ProductList extends StatelessWidget {
//   final List<DocumentSnapshot> products;
//   final Function(String) deleteProduct;

//   const ProductList({Key? key, required this.products, required this.deleteProduct}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: products.length,
//       itemBuilder: (context, index) {
//         Map<String, dynamic> productData = products[index].data() as Map<String, dynamic>;
//         String imagePath = productData['imagePath'] ?? ''; // Get image path

//         // Check if imagePath is a network URL or local file path
//         Widget imageWidget;
//         if (imagePath.startsWith('http')) {
//           // Network URL
//           imageWidget = Image.network(
//             imagePath,
//             width: 200,
//             height: 100,
//             fit: BoxFit.cover,
//           );
//         } else {
//           // Local file path (example)
//           imageWidget = Image.file(
//             File(imagePath),
//             width: 170,
//             height: 200,
//             fit: BoxFit.cover,
//           );
//         }

//         return Card(
//           elevation: 3,
//           margin: EdgeInsets.all(16),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               imageWidget, // Display the image
//               SizedBox(width: 16),
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.all(12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Product Name: ${productData['productName']}',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Size: ${productData['selectedSize']}',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         'Price: \$${productData['selectedPrice']}',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         'Quantity: ${productData['quantity']}',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       SizedBox(height: 8),
//                       ElevatedButton(
//                         onPressed: () {
//                           deleteProduct(products[index].id);
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.red,
//                           minimumSize: Size(100, 36),
//                         ),
//                         child: Text('Delete'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class TotalPriceCard extends StatelessWidget {
//   final double totalPrice;
//   final double shippingCost;
//   final List<DocumentSnapshot> clothProducts;
//   final Map<String, dynamic> userData;
//   final String? dropdownValue;
//   final BuildContext context;
//   final File? selectedImage;

//   const TotalPriceCard({
//     Key? key,
//     required this.totalPrice,
//     required this.shippingCost,
//     required this.clothProducts,
//     required this.userData,
//     required this.dropdownValue,
//     required this.context,
//     required this.selectedImage,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       color: Colors.grey[300],
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Shipping Cost: \$${shippingCost.toStringAsFixed(2)}', // Display shipping cost
//             style: TextStyle(fontSize: 16),
//           ),
//           SizedBox(height: 8), // Increased space below shipping cost
//           Text(
//             'Total Price: \$${totalPrice.toStringAsFixed(2)}',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           // SizedBox(height: 8), // Increased space below total price
//           // selectedImage != null ? Image.file( // Display selected image if available
//           //   selectedImage!,
//           //   width: 100,
//           //   height: 100,
//           //   fit: BoxFit.cover,
//           // ) : Container(), // Display empty container if no image selected
//           Container(
//             width: double.infinity, // Full width
//             decoration: BoxDecoration(
//               color: Colors.green, // Button background color
//               borderRadius: BorderRadius.circular(8), // Rounded corners
//             ),
//             child: TextButton(
//               onPressed: () {
//                 saveOrderToFirestore(
//                   context,
//                   clothProducts,
//                   totalPrice,
//                   shippingCost,
//                   userData,
//                   dropdownValue,
//                   selectedImage,
//                 );
//               }, // Call the saveOrderToFirestore method
//               style: TextButton.styleFrom(
//                 padding: EdgeInsets.symmetric(vertical: 16),
//               ),
//               child: Text(
//                 'Buy Now',
//                 style: TextStyle(
//                   color: Colors.white, // Button text color
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// void saveOrderToFirestore(
//   BuildContext context,
//   List<DocumentSnapshot> clothProducts,
//   double totalPrice,
//   double shippingCost,
//   Map<String, dynamic> userData,
//   String? dropdownValue,
//   File? selectedImage,
// ) async {
//   List<Map<String, dynamic>> productListData = clothProducts.map((product) => product.data() as Map<String, dynamic>).toList();

//   Map<String, dynamic> orderData = {
//     'totalPrice': totalPrice,
//     'shippingCost': shippingCost,
//     'products': productListData,
//     'userData': userData,
//     'paymentType': dropdownValue,
//     // Save selected image path if available
//     'selectedImage': selectedImage != null ? selectedImage.path : null,
//     // Add any other necessary data
//   };

//   try {
//     // Save order data to Firestore
//     await FirebaseFirestore.instance.collection('KAI').add(orderData);

//     // Clear the cart
//     await clearCart();

//     // Show a snackbar
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text('Order placed successfully!'),
//     ));

//     // Navigate to another page
//     Navigator.pop(context); // Pop current page
//     // You can navigate to another page here if needed
//     // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => ThankYouPage()));
//   } catch (e) {
//     // Handle any errors that occur during the save process
//     print('Error saving order: $e');
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text('Error placing order. Please try again later.'),
//     ));
//   }
// }

// Future<void> clearCart() async {
//   // Clear the cart by deleting all products
//   QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('cloth_product_add_to_cart').get();
//   List<QueryDocumentSnapshot> documents = querySnapshot.docs;
//   for (QueryDocumentSnapshot doc in documents) {
//     await doc.reference.delete();
//   }
// }


// //add to cart pop kluar