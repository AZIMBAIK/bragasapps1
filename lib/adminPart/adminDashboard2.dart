import 'package:bragasapps1/adminPart/AdminUpdateUserAccount';
import 'package:bragasapps1/adminPart/FetchProductHas2U2.dart';
import 'package:bragasapps1/adminPart/RetriveUserTripReg.dart';

import 'package:bragasapps1/allLoginPage/allLoginPage.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting


class Admin_dahboard2 extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {'title': 'Manage Users', 'icon': Icons.people, 'color': Colors.blue},
    {'title': 'Manage Order', 'icon': Icons.shopping_bag, 'color': Colors.green},
    {'title': 'Manage Trip Register', 'icon': Icons.shopping_cart, 'color': Colors.orange},
       {'title': 'Logout', 'icon': Icons.logout, 'color': Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        hintColor: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: AppBar(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.0),
                bottomRight: Radius.circular(24.0),
              ),
            ),
            flexibleSpace: _buildAppBarContent(),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 50.0,
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  DateFormat('EEE, MMM d, yyyy - hh:mm a').format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: double.infinity, // Full width
                    decoration: BoxDecoration(
                      color: Colors.yellow[800],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                      ),
                    ),
                    child: Container(
                      height: 90, // Adjust the height as needed
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         
                          SizedBox(width: 16.0),
                          Text(
                            ' ADMIN HOME PAGE',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            _navigateToScreen(context, index);
                          },
                          child: _buildGridItem(items[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserTable()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => FetchProductHas2U2()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => RetriveUserTripReg()));
        break;
        case 2:
       case 3:
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage2()));
      break;
    }
  }

  Widget _buildAppBarContent() {
    String imageUrl = 'https://media.istockphoto.com/id/1410270664/photo/modern-style-office-with-exposed-concrete-floor-and-a-lot-of-plants.webp?b=1&s=170667a&w=0&k=20&c=HWm7WsXeth_Iqtg8pSJr73s_bZjMZJKjKWCqhoxNtRs=';
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.0),
          bottomRight: Radius.circular(24.0),
        ),
      ),
    );
  }

  Widget _buildGridItem(Map<String, dynamic> item) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            item['icon'],
            size: 48.0,
            color: item['color'],
          ),
          SizedBox(height: 8.0),
           Text(
            item['title'],
            textAlign: TextAlign.center, // Align text to center
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: Center(child: Text('Users Screen')),
    );
  }
}

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: Center(child: Text('Products Screen')),
    );
  }
}

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text('Orders')),
      body: Center(child: Text('Orders Screen')),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(child: Text('Settings Screen')),
    );
  }
}

