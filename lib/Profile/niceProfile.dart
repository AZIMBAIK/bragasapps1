import 'dart:io';

import 'package:bragasapps1/Profile/UserCalander.dart';
import 'package:bragasapps1/Profile/viewOrderHistory.dart';

import 'package:bragasapps1/allLoginPage/allLoginPage.dart';
import 'package:bragasapps1/allLoginPage/registerUserTripU2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeautifulProfile extends StatefulWidget {
  @override
  _BeautifulProfileState createState() => _BeautifulProfileState();
}

class _BeautifulProfileState extends State<BeautifulProfile> {
  File? _image;
  final picker = ImagePicker();


  @override
  void initState() {
    super.initState();
    _fetchProfileImage();
  }

  Future<void> _fetchProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profileImagePath');
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  void _updateProfileImage(String imagePath) async {
    setState(() {
      _image = File(imagePath);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profileImagePath', imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 5,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100.0),
                bottomRight: Radius.circular(100.0),
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 90,
                      backgroundImage:
                          _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? Icon(
                              Icons.person,
                              size: 90,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Container(
                  height: 10,
                  color: Colors.transparent,
                ),
                Text(
                  'PROFILE',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                    ),
                    child: ListView(
                      children: [
                        ProfileCard(
                          title: 'Change Profile',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangeProfile(
                                      onImageUpdate: _updateProfileImage)),
                            );
                          },
                        ),

                          ProfileCard(
                          title: 'View Order History',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => viewRegisterTripHistory()),
                            );
                          },
                        ),

     ProfileCard(
  title: 'View Register Trip History',
  onTap: () async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      String currentUserEmail = user.email!; // Retrieve the current user's email
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => kosong10()),
      );
    } else {
      // Handle the case where the user is not logged in or their email is not available
    }
  },
),



                         ProfileCard(
                          title: 'Plan Trip',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UserCalendar()),
                            );
                          },
                        ),


                         ProfileCard(
                          title: 'Logout',
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage2()),
                            );
                          },
                        ),

                        // Other ProfileCard items...
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




class ProfileCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  ProfileCard({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(16),
        color: Colors.white,
        elevation: 5,
        child: ListTile(
          title: Text(title),
          trailing: Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}



class ChangeProfile extends StatefulWidget {
  final Function(String) onImageUpdate;

  ChangeProfile({required this.onImageUpdate});

  @override
  _ChangeProfileState createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  late String _uid;
  late Map<String, dynamic> _userData = {};
  File? _image;
  final picker = ImagePicker();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        _uid = user.uid;
      });

      final DocumentSnapshot userDataSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(_uid).get();

      setState(() {
        _userData = userDataSnapshot.data() as Map<String, dynamic>;
        _nameController.text = _userData['name'] ?? '';
        _emailController.text = _userData['email'] ?? '';
        _phoneController.text = _userData['phone'] ?? '';
        _addressController.text = _userData['address'] ?? '';
        _passwordController.text = _userData['password'] ?? '';
      });
    }
  }

  Future<void> _updateUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final String uid = user.uid;

      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(uid);

      await userDocRef.update({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
        'password': _passwordController.text,
        'profileImagePath': _image?.path ?? '',
      });

      widget.onImageUpdate(_image?.path ?? '');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully'),
        ),
      );

      // Pop the screen and navigate to another class
      Navigator.pop(context);
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => BeautifulProfile()),
      // );
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Profile'),
        centerTitle: true,
        backgroundColor:  Colors.yellow,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: _image != null
                          ? Image.file(_image!, fit: BoxFit.cover)
                          : Icon(Icons.camera_alt,
                              size: 50, color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildEditableUserDataItem('Name', _nameController),
                  _buildEditableUserDataItem('Email', _emailController),
                  _buildEditableUserDataItem('Phone', _phoneController),
                  _buildEditableUserDataItem('Address', _addressController),
                  _buildEditableUserDataItem('Password', _passwordController),
                  SizedBox(height: 16),
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _updateUserData,
                        child: Text('Update'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditableUserDataItem(
      String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
