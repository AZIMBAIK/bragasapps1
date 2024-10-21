import 'dart:io';

import 'package:bragasapps1/bragas_group/clothshopingU2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BuyScreen extends StatefulWidget {
  final String productName;
  final String selectedSize;
  final double selectedPrice;
  final int quantity;
  final String imagePath;

  const BuyScreen({
    required this.productName,
    required this.selectedSize,
    required this.selectedPrice,
    required this.quantity,
    required this.imagePath,
  });

  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  late File? _receiptPaymentImage;
  File? _selectedImage; // Added to store the selected image
  String? _selectedPaymentType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(widget.imagePath),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProductDetails(),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUserDetailsCard(),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Card(
                // margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PaymentSelectionCard(
                        onImageSelected: (file) {
                          setState(() {
                            _receiptPaymentImage = file;
                            _selectedImage = file; // Set the selected image here
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildBuyContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(String imagePath) {
    File imageFile = File(imagePath);
    if (imageFile.existsSync()) {
      return Image.file(
        imageFile,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 300, // Image height is set to 300
      );
    } else {
      return Text('Image not found');
    }
  }

  Widget _buildProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Product Name:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                widget.productName,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            Text(
              'Size:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Text(
                widget.selectedSize,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            Text(
              'Price:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Text(
                'RM ${(widget.selectedPrice * widget.quantity).toStringAsFixed(2)}',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            Text(
              'Quantity:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Text(
                widget.quantity.toString(),
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserDetailsCard() {
    return FutureBuilder(
      future: _fetchCurrentUserDetails(),
      builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading user details'));
        } else {
          final Map<String, dynamic>? userDetails = snapshot.data;
          if (userDetails != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Details:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Name: ${userDetails['name']}',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Phone: ${userDetails['phone']}',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Address: ${userDetails['address']}',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Email: ${userDetails['email']}',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _showEditUserDetailsPopup(context);
                  },
                  child: Text('Edit Details'),
                ),
              ],
            );
          } else {
            return Center(child: Text('User details not found'));
          }
        }
      },
    );
  }

  Future<Map<String, dynamic>?> _fetchCurrentUserDetails() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userDoc.exists) {
      return userDoc.data() as Map<String, dynamic>;
    } else {
      return null;
    }
  }

  void _showEditUserDetailsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditUserDataPopup(userId: FirebaseAuth.instance.currentUser!.uid);
      },
    );
  }

  Widget _buildBuyContainer() {
    var selectedPaymentType;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.0),
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipping Cost: RM 8.00',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            'Total Cost: RM ${(widget.selectedPrice * widget.quantity + 8.00).toStringAsFixed(2)}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

    //       Text(
    //   'Selected Payment Type: ${_selectedPaymentType ?? 'Not Selected'}',
    //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    // ),
          // SizedBox(height: 20.0),
          // Text(
          //   'Product Details:',
          //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          // ),
          // SizedBox(height: 8.0),
          // _buildProductDetailsWidget(),
          // SizedBox(height: 20.0),
          // Text(
          //   'User Details:',
          //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          // ),
          // SizedBox(height: 8.0),
          // _buildUserDetailsWidget(),
          // SizedBox(height: 20.0),
          // Text(
          //   'Receipt Payment Image:',
          //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          // ),
          // SizedBox(height: 8.0),
          // _buildReceiptPaymentImage(),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              _saveToFirebase();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: Center(
                  child: Text(
                    'BUY NOW',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.orange,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptPaymentImage() {
    if (_selectedImage != null) {
      return Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(_selectedImage!),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return Text('No receipt payment image selected');
    }
  }

  Widget _buildProductDetailsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Name: ${widget.productName}',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 8.0),
        Text(
          'Size: ${widget.selectedSize}',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 8.0),
        Text(
          'Price: RM ${(widget.selectedPrice * widget.quantity).toStringAsFixed(2)}',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 8.0),
        Text(
          'Quantity: ${widget.quantity}',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildUserDetailsWidget() {
    return FutureBuilder(
      future: _fetchCurrentUserDetails(),
      builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading user details'));
        } else {
          final Map<String, dynamic>? userDetails = snapshot.data;
          if (userDetails != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${userDetails['name']}',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Phone: ${userDetails['phone']}',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Address: ${userDetails['address']}',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Email: ${userDetails['email']}',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            );
          } else {
            return Center(child: Text('User details not found'));
          }
        }
      },
    );
  }

void _saveToFirebase() async {
  double totalCost = widget.selectedPrice * widget.quantity + 8.00;
  
  // Prepare data to be saved
  Map<String, dynamic> data = {
    'productName': widget.productName,
    'selectedSize': widget.selectedSize,
    'selectedPrice': widget.selectedPrice,
    'quantity': widget.quantity,
    'imagePath': widget.imagePath,
    'receiptPaymentImage': _receiptPaymentImage?.path,
    'totalCost': totalCost,
    'selectedPaymentType': _selectedPaymentType,
  };

  // Save user details
  Map<String, dynamic>? userDetails = await _fetchCurrentUserDetails();
  if (userDetails != null) {
    data.addAll({
      'userName': userDetails['name'],
      'userPhone': userDetails['phone'],
      'userAddress': userDetails['address'],
      'userEmail': userDetails['email'],
      'uid': FirebaseAuth.instance.currentUser!.uid, // Add current user's UID
    });
  }

  // Save data to Firebase
  try {
    await FirebaseFirestore.instance.collection('BUY').add(data);
    
    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment successful!')),
    );
    
    // Navigate to ClothShopU2
    Navigator.pop(
      context,
      MaterialPageRoute(builder: (context) => clothShopU2()),
    );
  } catch (e) {
    // Handle any errors that occur during the process
    print('Error saving data: $e');
    // Show an error message to the user
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred while processing your request. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
}

class PaymentSelectionCard extends StatefulWidget {
  final Function(File) onImageSelected;
  

  const PaymentSelectionCard({Key? key, required this.onImageSelected}) : super(key: key);

  @override
  _PaymentSelectionCardState createState() => _PaymentSelectionCardState();
}

class _PaymentSelectionCardState extends State<PaymentSelectionCard> {
  String? selectedPaymentType;
  String? accountNumber;
  File? _selectedImage;

  void updateAccountNumber(String? paymentType) {
    setState(() {
      selectedPaymentType = paymentType;
      if (paymentType == 'MAYBANK') {
        accountNumber = 'BRAGAS.SDN - NO ACC 2345';
      } else if (paymentType == 'CIMB BANK') {
        accountNumber = 'BRAGAS.SDN - NO ACC 12345';
      } else if (paymentType == 'RHB BANK') {
        accountNumber = 'BRAGAS.SDN -NO ACC 5789';
      } else if (paymentType == 'ISLAMIC BANK') {
        accountNumber = 'BRAGAS.SDN - NO ACC 4789';
      } else {
        accountNumber = null;
      }
    });
    
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
      widget.onImageSelected(_selectedImage!); // Notify parent widget with the selected image file
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Payment Type:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        DropdownButton<String>(
          value: selectedPaymentType,
          hint: Text('Select Payment Type'),
          onChanged: (newValue) {
            updateAccountNumber(newValue);
          },
          items: [
            'MAYBANK',
            'CIMB BANK',
            'RHB BANK',
            'ISLAMIC BANK',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        SizedBox(height: 16.0),
        Text(
          'Account Number:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          accountNumber ?? 'No Account Selected',
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: _getImage,
          child: Text('Upload Receipt Payment'),
        ),
        if (_selectedImage != null)
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(_selectedImage!),
                fit: BoxFit.cover,
              ),
            ),
          ),
      ],
    );
  }
}

class EditUserDataPopup extends StatefulWidget {
  final String userId;

  const EditUserDataPopup({Key? key, required this.userId}) : super(key: key);

  @override
  _EditUserDataPopupState createState() => _EditUserDataPopupState();
}

class _EditUserDataPopupState extends State<EditUserDataPopup> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();

    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').doc(widget.userId).get();
    if (snapshot.exists) {
      final userData = snapshot.data() as Map<String, dynamic>;
      setState(() {
        _nameController.text = userData['name'];
        _phoneController.text = userData['phone'];
        _addressController.text = userData['address'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit User Data'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveUserData,
          child: Text('Save'),
        ),
      ],
    );
  }

  void _saveUserData() {
    final newData = {
      'name': _nameController.text.trim(),
      'phone': _phoneController.text.trim(),
      'address': _addressController.text.trim(),
    };
    FirebaseFirestore.instance.collection('users').doc(widget.userId).update(newData);
    Navigator.pop(context); // Close the dialog
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
