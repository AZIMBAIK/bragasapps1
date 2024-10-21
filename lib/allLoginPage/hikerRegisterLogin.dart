import 'package:bragasapps1/core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HikerRegistrationPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future<void> registerHiker(BuildContext context) async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        addressController.text.isEmpty ||
        phoneController.text.isEmpty) {
      // Show a dialog informing the user to fill in all fields
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Incomplete Information'),
            content: Text('Please fill in all fields before registering.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return; // Exit the function early
    }

    if (passwordController.text.length < 6) {
      // Show a dialog informing the user that the password should be at least 6 characters long
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Password Too Short'),
            content: Text('Please enter a password of at least 6 characters.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return; // Exit the function early
    }

    try {
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      final User? user = userCredential.user;

      if (user != null) {
        // Store hiker data in Firestore with hiker role
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'uid': user.uid, // Add user UID
          'name': nameController.text,
          'email': emailController.text,
          'address': addressController.text, // Added address
          'phone': phoneController.text, // Added phone number
          'role': 'hiker',
          'password': passwordController.text,
        });

        // Navigate to Hiker dashboard after successful registration
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => button_nav(context)));
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage2()));

      }
    } catch (error) {
      // Handle registration error
      print('Registration error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Stack(
        fit: StackFit.expand,
        children: [
          BackgroundLogin(),
          Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.black.withOpacity(0.7),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "REGISTER FORM",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(color: Colors.yellow),
                            prefixIcon: Icon(Icons.person, color: Colors.yellow), // Icon for Name field
                          ),
                          style: TextStyle(color: Colors.yellow),
                        ),
                        SizedBox(height: 12.0),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(color: Colors.yellow),
                            prefixIcon: Icon(Icons.email, color: Colors.yellow), // Icon for Email field
                          ),
                          style: TextStyle(color: Colors.yellow),
                        ),
                        SizedBox(height: 12.0),
                        TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(color: Colors.yellow),
                            prefixIcon: Icon(Icons.lock, color: Colors.yellow), // Icon for Password field
                          ),
                          style: TextStyle(color: Colors.yellow),
                          obscureText: true,
                        ),
                        SizedBox(height: 12.0),
                        TextField(
                          controller: addressController,
                          decoration: InputDecoration(
                            labelText: 'Address',
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(color: Colors.yellow),
                            prefixIcon: Icon(Icons.home, color: Colors.yellow), // Icon for Address field
                          ),
                          style: TextStyle(color: Colors.yellow),
                        ),
                        SizedBox(height: 12.0),
                        TextField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(color: Colors.yellow),
                            prefixIcon: Icon(Icons.phone, color: Colors.yellow), // Icon for Phone Number field
                          ),
                          style: TextStyle(color: Colors.yellow),
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () => registerHiker(context),
                          child: Text('Register as Hiker'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
