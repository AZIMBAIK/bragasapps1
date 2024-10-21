
// import 'package:bragasapps1/adminPart/adminlogin.dart';
// import 'package:bragasapps1/allLoginPage/allLoginPage.dart';
// import 'package:bragasapps1/bragas_group/bragas_login%20.dart';
// import 'package:bragasapps1/core.dart';
// import 'package:flutter/material.dart';

// class FirstPage extends StatefulWidget {
//   const FirstPage({Key? key}) : super(key: key);

//   @override
//   State<FirstPage> createState() => _FirstPageState();
// }

// class _FirstPageState extends State<FirstPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           BackgroundLogin(), // Your BackgroundLogin widget with the background image
//           Positioned(
//             top: 180,
//             left: 90,

//             right: 90,
//             child: Image.asset(
//               "assets/bragas.jpeg",
//               width: 200.0,
//               height: 200.0,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.fromLTRB(30, 250, 30, 0),
//             child: Center(
//   child: Card(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(15.0),
//     ),
//     margin: EdgeInsets.all(20.0),
//     elevation: 5.0,
//     child: Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SizedBox(
//             width: 200,
//             height: 50,
//             // child: ElevatedButton(
//             //   style: ElevatedButton.styleFrom(
//             //     foregroundColor: Colors.black, backgroundColor: Colors.yellow,
//             //     shape: RoundedRectangleBorder(
//             //       borderRadius: BorderRadius.circular(10.0),
//             //     ),
//             //   ),
//             //   onPressed: () {
//             //     Navigator.push(
//             //       context,
//             //       MaterialPageRoute(builder: (context) => adminLogin1()),
//             //     );
//             //   },
//             //   child: const Text("Admin Login"),
//             // ),
//           ),
//           const SizedBox(height: 20), // Space between buttons
//           SizedBox(
//             width: 200,
//             height: 50,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.black, backgroundColor: Colors.yellow,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginPage2()),
//                 );
//               },
//               child: const Text("User Login"),
//             ),
//           ),
//           SizedBox(height: 20,),
//           SizedBox(
//             width: 200,
//             height: 50,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.black, backgroundColor: Colors.yellow,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => bragasLogin()),
//                 );
//               },
//               child: const Text("Bragas Group Login"),
//             ),
//           ),
//         ],
//       ),
//     ),
//   ),
// )

//           ),
//         ],
//       ),
//     );
//   }
// }
