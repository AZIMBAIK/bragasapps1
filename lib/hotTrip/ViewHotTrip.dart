import 'package:bragasapps1/dashboardALL/dashboardMain.dart';
import 'package:bragasapps1/hotTrip/MountainView.dart';

import 'package:bragasapps1/hotTrip/Waterfallview.dart';
import 'package:bragasapps1/hotTrip/reallTodayTripView.dart';
import 'package:flutter/material.dart';


class HotTripView extends StatefulWidget {
  @override
  _HotTripViewState createState() => _HotTripViewState();
}

class _HotTripViewState extends State<HotTripView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Widget> pages = [
    realTodayTripView(),
    mountview1(),
    WaterfallViewPage()
   
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: pages.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    child: Image.network(
                      "https://media.istockphoto.com/id/483771218/photo/moraine-lake-at-sunset.webp?b=1&s=170667a&w=0&k=20&c=s7L_yGia7gIgPZidLCOiyViTvPkeXHrN37yXMNgoTP8=",
                      width: double.infinity,
                      height: 240.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 24.0,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      dashMain()), // Replace Container() with your desired widget
                            );
                          },
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        // Expanded(
                        //   child: Align(
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       "Dashboard",
                        //       style: TextStyle(
                        //         color: Colors.white70,
                        //         fontSize: 30,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        child: Expanded(
                          child: Column(
                            children: [
                              Container(
                                child: Text(
                                  "HOT TRIP",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.black87,
                                  ),
                                ),
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              ),
                              Column(
                                children: [
                                  TabBar(
                                    controller: _tabController,
                                    tabs: [
                                      Tab(text: 'Poster Trip'),
                                      Tab(text: 'Mountain Trail'),
                                      Tab(text: 'Waterfall Trail'),
                                  
                                    ],
                                    isScrollable: true,
                                    labelColor: Colors.black,
                                    unselectedLabelColor: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 490,
                                    child: TabBarView(
                                      controller: _tabController,
                                      children: pages,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        width: double.infinity,
                        height: 600,
                        margin: EdgeInsets.fromLTRB(0, 219, 0, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            topRight: Radius.circular(50.0),
                          ),
                          color: Color.fromARGB(255, 250, 250, 250),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
