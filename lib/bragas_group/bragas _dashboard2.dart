import 'package:bragasapps1/allLoginPage/allLoginPage.dart';
import 'package:bragasapps1/bragas_group/addProductFirsPageU2.dart';
import 'package:bragasapps1/bragas_group/addtripFirstPage.dart';
import 'package:bragasapps1/bragas_group/bragasComunitty.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class BragasDashboard2 extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {'title': 'Manage Community Activity', 'icon': Icons.people, 'color': Colors.blue},
    {'title': 'Manage Trip', 'icon': Icons.shopping_bag, 'color': Colors.green},
    {'title': 'Manage Product', 'icon': Icons.shopping_cart, 'color': Colors.orange},
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
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3),
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
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black, // Updated background color
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                        bottomLeft: Radius.circular(24.0),
                        bottomRight: Radius.circular(24.0),
                      ),
                    ),
                    child: Container(
                      height: 90,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // CircleAvatar(
                          //   radius: 30.0,
                          //   backgroundImage: NetworkImage(
                          //     'https://media.istockphoto.com/id/1214961498/photo/portrait-of-chinese-male-medical-healthcare-worker-hand-holding-note-pad-with-smiling-face.webp?b=1&s=170667a&w=0&k=20&c=l77qWU_5vVOfwgUkx2dEnWctdzApkzetpm960qFdcZU=',
                          //   ),
                          // ),
                          SizedBox(width: 16.0),
                          Text(
                            'BRAGAS HOME PAGE',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Text color
                              shadows: [
                                Shadow(
                                  color: Colors.yellow,
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                ),
                              ],
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => bragasComunitty()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddTripFirstpage()));
        break;
      case 2:
      Navigator.push(context, MaterialPageRoute(builder: (context) => addProductFirsPageU2()));

        break;
      case 3:
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage2()));
        break;
      default:
        break;
    }
  }

  

  Widget _buildAppBarContent() {
    String imageUrl = 'https://images.unsplash.com/photo-1497032628192-86f99bcd76bc?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fG9mZmljZXxlbnwwfHwwfHx8MA%3D%3D';
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black, width: 1.0), // Black border
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item['icon'],
              size: 48.0,
              color: item['color'],
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                item['title'],
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


