import 'package:bragasapps1/core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class userRegisterTrip extends StatefulWidget {
  @override
  _userRegisterTripState createState() => _userRegisterTripState();
}

class _userRegisterTripState extends State<userRegisterTrip> {
  late User _user;
  String? selectedPackageName;
  double totalPrice = 0.0;
  Map<String, dynamic>? selectedPackageData;
  File? _selectedImage; // Updated to be a class variable

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    var _selectedImagePath;
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Data'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showEditUserDataPopup();
                      },
                      child: UserDataCard(userId: _user.uid),
                    ),
                    SizedBox(height: 16),
                    PaymentSelectionCard(onImageSelected: _handleImageSelected),
                    SizedBox(height: 16),
                    SelectPackageCard(onPackageSelected: _handlePackageSelected),
                    SizedBox(height: 16),
                    if (selectedPackageData != null)
                      PackageDetailsCard(packageData: selectedPackageData!),
                  ],
                ),
              ),
            ),
          ),
          YellowContainer(
            totalPrice: totalPrice,
            selectedPackageName: selectedPackageName,
            onBuyPressed: () {
              if (selectedPackageData != null) {
                // Deduct limit by 1
                int currentLimit = int.parse(selectedPackageData!['limit']);
                if (currentLimit > 0) {
                  FirebaseFirestore.instance
                      .collection('adminPostPoster')
                      .doc(selectedPackageData!['packageName'])
                      .update({'limit': (currentLimit - 1).toString()});
                }
              }
              // Implement your buy logic here
              print('Buy button pressed');
            },
            name: '',
            email: '',
            phone: '',
            address: '',
            uid: '',
            imagePath: _selectedImage != null ? _selectedImage!.path : '',
            limit: selectedPackageData != null
                ? selectedPackageData!['limit']?.toString() ?? 'N/A'
                : 'N/A', // Add null check for limit
            // Pass _selectedImagePath to YellowContainer
          ),
        ],
      ),
    );
  }

  Widget _buildUserDataCard() {
    return UserDataCard(userId: _user.uid);
  }

  void _handleImageSelected(File imageFile) {
    print('Selected image: ${imageFile.path}');
    setState(() {
      _selectedImage = imageFile; // Set _selectedImage with the selected image file
    });
  }

  void _handlePackageSelected(Map<String, dynamic> selectedPackage) {
    setState(() {
      selectedPackageName = selectedPackage['packageName'];
      totalPrice = selectedPackage['price'];
      selectedPackageData = selectedPackage;
      selectedPackageData!['limit'] =
          selectedPackage['limit']; // Add limit data to selectedPackageData
    });
  }

  void _showEditUserDataPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditUserDataPopup(userId: _user.uid);
      },
    );
  }
}
class UserDataCard extends StatelessWidget {
  final String userId;

  const UserDataCard({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      elevation: 3.0,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            var userData = snapshot.data?.data() as Map<String, dynamic>?;
            if (userData == null) {
              return Text('No user data available.');
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('User Data', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 16.0),
                _buildDataContainer(Icons.person, 'Name', userData['name']),
                _buildDataContainer(Icons.email, 'Email', userData['email']),
                _buildDataContainer(Icons.phone, 'Phone', userData['phone']),
                _buildDataContainer(Icons.location_on, 'Address', userData['address']),
                _buildDataContainer(Icons.vpn_key, 'UID', userId),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDataContainer(IconData iconData, String label, String? data) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            iconData,
            size: 24,
            color: Colors.black87,
          ),

          
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  data ?? 'N/A',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
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
    var snapshot = await FirebaseFirestore.instance.collection('users').doc(widget.userId).get();
    var userData = snapshot.data();
    if (userData != null) {
      _nameController.text = userData['name'] ?? '';
      _phoneController.text = userData['phone'] ?? '';
      _addressController.text = userData['address'] ?? '';
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
        accountNumber = '2345';
      } else if (paymentType == 'CIMB BANK') {
        accountNumber = '12345';
      } else if (paymentType == 'RHB BANK') {
        accountNumber = '5789';
      } else if (paymentType == 'ISLAMIC BANK') {
        accountNumber = '4789';
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
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      elevation: 3.0,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
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
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(_selectedImage!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SelectPackageCard extends StatefulWidget {
  final Function(Map<String, dynamic>) onPackageSelected;

  const SelectPackageCard({Key? key, required this.onPackageSelected}) : super(key: key);

  @override
  _SelectPackageCardState createState() => _SelectPackageCardState();
}

class _SelectPackageCardState extends State<SelectPackageCard> {
  String? selectedPackageName;
  List<Map<String, dynamic>> packages = [];

  @override
  void initState() {
    super.initState();
    _fetchPackages();
  }

  Future<void> _fetchPackages() async {
    final snapshot = await FirebaseFirestore.instance.collection('adminPostPoster').get();
    if (snapshot.docs.isNotEmpty) {
      packages = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      elevation: 3.0,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Package:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            DropdownButton<String>(
              value: selectedPackageName,
              hint: Text('Select Package'),
              onChanged: (newValue) {
                final selectedPackage = packages.firstWhere((pkg) => pkg['packageName'] == newValue);
                widget.onPackageSelected(selectedPackage);
                setState(() {
                  selectedPackageName = newValue;
                });
              },
              items: packages.map<DropdownMenuItem<String>>((package) {
                return DropdownMenuItem<String>(
                  value: package['packageName'].toString(),
                  child: Text(package['packageName'].toString()),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class PackageDetailsCard extends StatelessWidget {
  final Map<String, dynamic> packageData;

  const PackageDetailsCard({Key? key, required this.packageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      elevation: 3.0,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Package Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 16.0),
            _buildDataItem('Date', packageData['date'].toString()),
            SizedBox(height: 8.0),
            ImageFromPath(imagePath: packageData['imagePath'].toString()),
            SizedBox(height: 16.0),
            _buildDataItem('Limit', packageData['limit'].toString()),
            _buildDataItem('Package Name', packageData['packageName'].toString()),
            _buildDataItem('Price', '\$${packageData['price']}'),
            _buildDataItem('Timestamp', _formatTimestamp(packageData['timestamp'])),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat.yMMMMd().format(dateTime);
  }

  Widget _buildDataItem(String label, String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              data,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageFromPath extends StatelessWidget {
  final String imagePath;

  const ImageFromPath({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imagePath.isNotEmpty
        ? Image.file(
            File(imagePath),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          )
        : Container(
            color: Colors.grey,
            width: double.infinity,
            height: 200,
            child: Center(
              child: Text(
                'No Image Available',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          );
  }
}


class YellowContainer extends StatelessWidget {
  final double totalPrice;
  final String? selectedPackageName;
  final VoidCallback onBuyPressed;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String uid;
  final String limit;
  final String imagePath; // Added imagePath parameter

  const YellowContainer({
    Key? key,
    required this.totalPrice,
    required this.selectedPackageName,
    required this.onBuyPressed,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.uid,
    required this.limit, 
    required this.imagePath, // Added imagePath parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading indicator while fetching data
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || snapshot.data!.data() == null) {
          return Text('No user data found.'); // Handle if user data is not available
        }

        Map<String, dynamic> userData = snapshot.data!.data()!;
        return Container(
          color: Colors.yellow,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Package Name: $selectedPackageName',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Limit: $limit', // Display limit
                style: TextStyle(fontSize: 16),
              ),
           
       // Display image from imagePath
          SizedBox(height: 16),
          ElevatedButton(
  onPressed: () {
    // Call saveToFirestore with necessary data
    saveToFirestore(selectedPackageName!, totalPrice, userData, imagePath,limit);
    // Show a SnackBar indicating payment success
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment successful'),
        duration: Duration(seconds: 2), // Adjust duration as needed
      ),
    );
    // Navigate to hotTrip() page after a delay
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => HotTripView()),
      );
    });
  },
  child: Text('Buy', style: TextStyle(fontSize: 16)),
),

            ],
          ),
        );
      },
    );
  }

void saveToFirestore(String selectedPackageName, double totalPrice, Map<String, dynamic> userData, String imagePath, String limit) {
  // Extract user details from userData map
  String name = userData['name'] ?? 'N/A';
  String email = userData['email'] ?? 'N/A';
  String phone = userData['phone'] ?? 'N/A';
  String address = userData['address'] ?? 'N/A';
  String uid = userData['uid'] ?? 'N/A'; // Include user's UID

  // Save data to Firestore with user details included
  FirebaseFirestore.instance.collection('love').add({
    'packageName': selectedPackageName,
    'totalPrice': totalPrice,
    'name': name, // Include user's name
    'email': email, // Include user's email
    'phone': phone, // Include user's phone
    'address': address, // Include user's address
    'uid': uid, // Include user's UID
    'imagePath': imagePath,
    'limit': limit,
    'timestamp': FieldValue.serverTimestamp(),
  }).then((value) {
    print('Data saved to Firestore');
    // Decrease the limit in adminPostPoster by 1
    decreaseLimit(selectedPackageName);
  }).catchError((error) {
    print('Error saving data: $error');
  });
}

  // Function to decrease the limit in adminPostPoster by 1
  void decreaseLimit(String selectedPackageName) {
    FirebaseFirestore.instance.collection('adminPostPoster').where('packageName', isEqualTo: selectedPackageName).get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        int currentLimit = doc['limit'] ?? 0;
        // Update the limit in Firestore by decrementing 1
        doc.reference.update({'limit': currentLimit - 1});
      });
    }).catchError((error) {
      print('Error decreasing limit: $error');
    });
  }
}
