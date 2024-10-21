

// import 'package:bragasapps1/bragas_group/UpdateOrder.dart';
// import 'package:bragasapps1/bragas_group/bragasComunitty.dart';
// import 'package:bragasapps1/bragas_group/bragasUpdatePoster.dart';
// import 'package:bragasapps1/core.dart';
// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';



// class bragasDashboardMain extends StatefulWidget {
//   const bragasDashboardMain({Key? key}) : super(key: key);

//   @override
//   _bragasDashboardMainState createState() => _bragasDashboardMainState();
// }

// class _bragasDashboardMainState extends State<bragasDashboardMain> {
//   late CalendarFormat _calendarFormat;
//   late DateTime _focusedDay;
//   late DateTime _selectedDay;

//   @override
//   void initState() {
//     super.initState();
//     _calendarFormat = CalendarFormat.month;
//     _focusedDay = DateTime.now();
//     _selectedDay = DateTime.now();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor:  Colors.yellow,
//         // title: const Text("Adminlogin"),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
            
//         UserAccountsDrawerHeader(
//                   accountName: const Text(" BRAGAS GROUP"),
//                   accountEmail: const Text("bragas@gmail.com"),
//                   currentAccountPicture: const CircleAvatar(
//                     backgroundImage: NetworkImage(
//                         "https://images.unsplash.com/photo-1600486913747-55e5470d6f40?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"),
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.blueGrey[900],
//                   ),
//                   otherAccountsPictures: const [
//                     // CircleAvatar(
//                     //   backgroundColor: Colors.white,
//                     //   backgroundImage: NetworkImage(
//                     //       "https://randomuser.me/api/portraits/women/74.jpg"),
//                     // ),
//                     // CircleAvatar(
//                     //   backgroundColor: Colors.white,
//                     //   backgroundImage: NetworkImage(
//                     //       "https://randomuser.me/api/portraits/men/47.jpg"),
//                     // ),
//                   ],
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.home),
//                   title: const Text("Plan Trip"),
//                   // onTap: () {
//                   //   Navigator.push(
//                   //     context,
//                   //     MaterialPageRoute(builder: (context) => AdminViewTripform()),
//                   //   );
//                   // },
//                 ),
//                 //  ListTile(
//                 //   leading: const Icon(Icons.home),
//                 //   title: const Text("Manage Payment Trip"),
//                 //   onTap: () {
//                 //     Navigator.push(
//                 //       context,
//                 //       MaterialPageRoute(builder: (context) => AdminViewTripform()),
//                 //     );
//                 //   },
//                 // ),

//                  ListTile(
//                   leading: const Icon(Icons.home),
//                   title: const Text("Manage product"),
//                   // onTap: () {
//                   //   Navigator.push(
//                   //     context,
//                   //     MaterialPageRoute(builder: (context) => AdminViewTripform()),
//                   //   );
//                   // },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.code),
//                   title: const Text("Manage Poster Trip"),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => FetchBuy()),
//                     );
//                   }
//                 ),
               
//                 ListTile(
//                   leading: const Icon(Icons.privacy_tip),
//                   title: const Text("Manage community activity"),
//                   onTap: () {
//                       Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => bragasComunitty()),
//                       );
//                   },
//                 ),
            
//                 // ListTile(
//                 //   leading: const Icon(Icons.privacy_tip),
//                 //   title: const Text("Manage Poster"),
//                 //   onTap: () {
//                 //       Navigator.push(
//                 //       context,
//                 //       MaterialPageRoute(builder: (context) => adminUpdatePoster()),
//                 //       );
//                 //   },
//                 // ),
//                 // ListTile(
//                 //   leading: const Icon(
//                 //     Icons.logout,
//                 //   ),
//                 //   title: const Text("Logout"),
//                 //   onTap: () {
//                 //      Navigator.push(
//                 //       context,
//                 //       MaterialPageRoute(builder: (context) => bragasLogin()),);
                    
//                 //   },
//                 // )


//               ],
//             ),
//           ),
       
//       body: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             height: 100,
//             color: Colors.black,
//             child: Center(
//               child: Text(
//                 'BRAGAS GROUP',
                
//                 textAlign:TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 40,fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
                    
//                     margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                     height: 180.0,
//                     width: 400,
//                     padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                         image: NetworkImage(
//                           "https://images.unsplash.com/photo-1533050487297-09b450131914?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
//                         ),
//                         fit: BoxFit.cover,
//                       ),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(
//                           16.0,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
                    
//                     padding: EdgeInsets.all(16.0),
//                     color: Colors.white10,
//                     child: TableCalendar(
//                       firstDay: DateTime.utc(2010, 10, 16),
//                       lastDay: DateTime.utc(2030, 3, 14),
//                       focusedDay: _focusedDay,
//                       calendarFormat: _calendarFormat,
//                       selectedDayPredicate: (day) {
//                         return isSameDay(_selectedDay, day);
//                       },
//                       onDaySelected: (selectedDay, focusedDay) {
//                         setState(() {
//                           _selectedDay = selectedDay;
//                           _focusedDay = focusedDay;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
