import 'package:bragasapps1/bragas_group/shopingFirstPageU2.dart';
import 'package:bragasapps1/community.dart/comView2.dart';
import 'package:bragasapps1/dashboardALL/dashboardMain.dart';
import 'package:bragasapps1/Profile/niceProfile.dart';


import 'package:flutter/material.dart';

class button_nav extends StatefulWidget {
  button_nav(BuildContext context);

  @override
  _button_navState createState() => _button_navState();
}

class _button_navState extends State<button_nav> {
  int _currentIndex = 0;

  final _pages = [
    dashMain(),
    comView2 (),
    // shoopingALL(),
    ShopingFirstPageU2(),
    BeautifulProfile(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 17, 17, 17),
        selectedItemColor:
            Colors.yellow, // Color for selected item's icon and label
        unselectedItemColor:
            Colors.grey, // Color for unselected items' icon and label
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.facebook),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Shopping',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
