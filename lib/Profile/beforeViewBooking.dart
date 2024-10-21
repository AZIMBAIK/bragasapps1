// import 'package:flutter/material.dart';
// import 'package:bragasapps1/Profile/pendingbooking.dart';
// import 'package:bragasapps1/Profile/succesfulbooking.dart';
// import 'package:bragasapps1/dashboardALL/dashboardMain.dart';
// import 'package:bragasapps1/hotTrip/MountainView.dart';
// import 'package:bragasapps1/hotTrip/TodayTripView.dart';
// import 'package:bragasapps1/hotTrip/Waterfallview.dart';

// class beforeViewBooking extends StatefulWidget {
//   @override
//   _beforeViewBookingState createState() => _beforeViewBookingState();
// }

// class _beforeViewBookingState extends State<beforeViewBooking>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   final List<Widget> pages = [
//     // ViewBooking(),
//     SuccesfulBooking(),
//     // ... Add more pages here if needed
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: pages.length, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2, // Number of tabs
//       child: Scaffold(
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 30.0,
//                   child: Container(
//                     color: Color.fromARGB(0, 212, 1, 1),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10.0),
//                   child: Text(
//                     "View Booking Trip",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 25,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//                 TabBar(
//                   controller: _tabController,
//                   tabs: [
//                     // Tab(
//                     //   child: Align(
//                     //     alignment: Alignment.center,
//                     //     child: Text('Pending'),
//                     //   ),
//                     // ),
//                     Tab(
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: Text('Successful'),
//                       ),
//                     ),
//                   ],
//                   isScrollable: true,
//                   labelColor: Colors.black,
//                   unselectedLabelColor: Colors.grey,
//                 ),
//                 SizedBox(
//                   height: 490,
//                   child: TabBarView(
//                     controller: _tabController,
//                     children: pages,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
