import 'package:bragasapps1/adminPart/adminDashboard2.dart';

import 'package:bragasapps1/allLoginPage/hikerRegisterLogin.dart';
import 'package:bragasapps1/bragas_group/bragas%20_dashboard2.dart';
import 'package:bragasapps1/bragas_group/bragas_dashboardMain.dart';
import 'package:bragasapps1/core.dart';
import 'package:bragasapps1/dashboardALL/buttonNav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bragasapps1/allLoginPage/backgroundimg.dart';

class LoginPage2 extends StatefulWidget {
  @override
  _LoginPage2State createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

 void login() async {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  if (email.isEmpty || password.isEmpty) {
    setState(() {
      errorMessage = 'Please enter email and password';
    });
    return;
  }

  try {
    // Firebase Authentication for email and password
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Check the role from Firestore after successful authentication
    var user = userCredential.user;
    if (user != null) {
      var snapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      var userData = snapshot.data();
      if (userData != null && userData['role'] == 'hiker') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => button_nav(context)),  // Correctly navigate based on UID
        );
      } else {
        // Handle other roles or error
        setState(() {
          errorMessage = 'Unauthorized access or incorrect role';
        });
      }
    }
  } on FirebaseAuthException catch (e) {
    setState(() {
      errorMessage = e.message ?? 'Login failed';
    });
  }

  // Check for admin credentials
  if (email == 'admin@gmail.com' && password == 'a12345') {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Admin_dahboard2()),
    );
    return;
  }

  // Check for bragas credentials
  if (email == 'bragas@gmail.com' && password == 'b12345') {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BragasDashboard2()),
    );
    return;
  }
}

void navigateToRegistration() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HikerRegistrationPage()),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          BackgroundLogin(), // Your BackgroundLogin widget with the background image
          Positioned(
            top: 100,
            left: 90,
            right: 90,
            child: Image.asset(
              "assets/bragas.jpeg",
              width: 200.0,
              height: 200.0,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              color: Colors.black.withOpacity(0.3),
              padding: EdgeInsets.fromLTRB(10, 300, 10, 0),
              child: Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.black.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "LOGIN NOW",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.yellow,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          maxLength: 20,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Colors.yellow,
                            ),
                            suffixIcon: Icon(
                              Icons.email,
                              color: Colors.yellow,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.yellow,
                          ),
                          controller: emailController,
                          onChanged: (value) {
                            setState(() {
                              errorMessage = '';
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          maxLength: 20,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: Colors.yellow,
                            ),
                            suffixIcon: Icon(
                              Icons.password,
                              color: Colors.yellow,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.yellow,
                          ),
                          controller: passwordController,
                          onChanged: (value) {
                            setState(() {
                              errorMessage = '';
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            minimumSize: Size(double.infinity, 46),
                          ),
                          onPressed: login,
                          child: const Text("Login"),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            minimumSize: Size(double.infinity, 46),
                          ),
                          onPressed: navigateToRegistration,
                          child: const Text("Register"),
                        ),
                        SizedBox(height: 10),
                        errorMessage.isNotEmpty
                            ? Text(
                                errorMessage,
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              )
                            : SizedBox(),
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
















// first baik tapi xde bragas

// import 'package:bragasapps1/adminPart/adminlogin.dart';

// import 'package:bragasapps1/allLoginPage/hikerRegisterLogin.dart';
// import 'package:bragasapps1/bragas_group/bragas%20_dashboard2.dart';
// import 'package:bragasapps1/bragas_group/bragas_dashboardMain.dart';
// import 'package:bragasapps1/dashboardALL/buttonNav.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:bragasapps1/allLoginPage/backgroundimg.dart';

// class LoginPage2 extends StatefulWidget {
//   @override
//   _LoginPage2State createState() => _LoginPage2State();
// }

// class _LoginPage2State extends State<LoginPage2> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   String errorMessage = '';

//  void login() async {
//   String email = emailController.text.trim();
//   String password = passwordController.text.trim();

//   if (email.isEmpty || password.isEmpty) {
//     setState(() {
//       errorMessage = 'Please enter email and password';
//     });
//     return;
//   }

//   try {
//     // Firebase Authentication for email and password
//     UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );

//     // Check the role from Firestore after successful authentication
//     var user = userCredential.user;
//     if (user != null) {
//       var snapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
//       var userData = snapshot.data();
//       if (userData != null && userData['role'] == 'hiker') {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => button_nav(context)),  // Correctly navigate based on UID
//         );
//       } else {
//         // Handle other roles or error
//         setState(() {
//           errorMessage = 'Unauthorized access or incorrect role';
//         });
//       }
//     }
//   } on FirebaseAuthException catch (e) {
//     setState(() {
//       errorMessage = e.message ?? 'Login failed';
//     });
//   }
// }


//   if (email == 'admin@gmail.com' && password == 'a12345') {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => Admin_dahboard2()),
//         );
//         return;
//       }

//       // Check for hardcoded bragas credentials
//       if (email == 'bragas@gmail.com' && password == 'b12345') {
//         Navigator.pushReplacement(
//           context,
//           // MaterialPageRoute(builder: (context) => bragasDashboardMain()),
//            MaterialPageRoute(builder: (context) => BragasDashboard2()),
         
//         );
//         return;
//       }
//   void navigateToRegistration() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => HikerRegistrationPage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           BackgroundLogin(), // Your BackgroundLogin widget with the background image
//           Positioned(
//             top: 100,
//             left: 90,
//             right: 90,
//             child: Image.asset(
//               "assets/bragas.jpeg",
//               width: 200.0,
//               height: 200.0,
//               fit: BoxFit.cover,
//             ),
//           ),
//           SingleChildScrollView(
//             child: Container(
//               color: Colors.black.withOpacity(0.3),
//               padding: EdgeInsets.fromLTRB(10, 300, 10, 0),
//               child: Center(
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15.0),
//                   ),
//                   color: Colors.black.withOpacity(0.5),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           "LOGIN NOW",
//                           style: TextStyle(
//                             fontSize: 20.0,
//                             color: Colors.yellow,
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           maxLength: 20,
//                           decoration: InputDecoration(
//                             labelText: 'Email',
//                             labelStyle: TextStyle(
//                               color: Colors.yellow,
//                             ),
//                             suffixIcon: Icon(
//                               Icons.email,
//                               color: Colors.yellow,
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.white),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.yellow),
//                             ),
//                           ),
//                           style: TextStyle(
//                             color: Colors.yellow,
//                           ),
//                           controller: emailController,
//                           onChanged: (value) {
//                             setState(() {
//                               errorMessage = '';
//                             });
//                           },
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           maxLength: 20,
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             labelText: 'Password',
//                             labelStyle: TextStyle(
//                               color: Colors.yellow,
//                             ),
//                             suffixIcon: Icon(
//                               Icons.password,
//                               color: Colors.yellow,
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.yellow),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.yellow),
//                             ),
//                           ),
//                           style: TextStyle(
//                             color: Colors.yellow,
//                           ),
//                           controller: passwordController,
//                           onChanged: (value) {
//                             setState(() {
//                               errorMessage = '';
//                             });
//                           },
//                         ),
//                         SizedBox(height: 20),
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.yellow,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             minimumSize: Size(double.infinity, 46),
//                           ),
//                           onPressed: login,
//                           child: const Text("Login"),
//                         ),
//                         SizedBox(height: 10),
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.yellow,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             minimumSize: Size(double.infinity, 46),
//                           ),
//                           onPressed: navigateToRegistration,
//                           child: const Text("Register"),
//                         ),
//                         SizedBox(height: 10),
//                         errorMessage.isNotEmpty
//                             ? Text(
//                                 errorMessage,
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                 ),
//                               )
//                             : SizedBox(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
