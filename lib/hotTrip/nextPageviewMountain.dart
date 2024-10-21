import 'package:bragasapps1/core.dart';
import 'package:bragasapps1/hotTrip/ViewHotTrip.dart';
import 'package:bragasapps1/maping_All.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class nextPageViewMountain extends StatefulWidget {
  final int index;

  const nextPageViewMountain({Key? key, required this.index}) : super(key: key);

  @override
  State<nextPageViewMountain> createState() => _nextPageViewMountainState();
}

class _nextPageViewMountainState extends State<nextPageViewMountain> {
  Mount1 productController2 = Mount1();
  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GestureDetector(
            child: Container(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        child: Container(
                          height: 280.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(productController2
                                  .imagesWithText[index]['imageUrl']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        color: Color.fromARGB(100, 22, 44, 33),
                      ),
                      Positioned(
                        top: 20,
                        left: 10,
                        child: CircleAvatar(
                          backgroundColor: Colors.black87,
                          child: IconButton(
                            icon: Icon(Icons
                                .arrow_back), // Add your back button icon here
                            onPressed: () {
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HotTripView()),
                              );
                              // Call the HotTripView function when the back button is pressed
                              HotTripView();
                            },
                            color: Colors.white, // Set the icon color
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${productController2.imagesWithText[index]['kerunai']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25)),
                          ],
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RatingBarIndicator(
                              rating: double.parse(productController2
                                  .imagesWithText[index]['rating']),
                              itemCount: 5,
                              itemSize: 30.0,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 60,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${productController2.imagesWithText[index]['Location']}',
                                style: TextStyle(fontSize: 17)),
                            const Icon(
                              Icons.location_on,
                              size: 24.0,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        Divider(
                          thickness: 5.0, // Adjust the thickness as needed
                          color: Colors.black, // Adjust the color as needed
                        ),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'DESCRIPTION',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ],
                              ),
                              SizedBox(height: 7),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    // Use Expanded to make the Text widget take available width
                                    child: Text(
                                      ' ${productController2.imagesWithText[index]['description']}',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                      maxLines:
                                          5, // Set the maximum number of lines
                                      overflow: TextOverflow
                                          .ellipsis, // Optional: Add ellipsis (...) if the text overflows
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                    
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.wifi,
                                size: 60.0,
                              ),
                              const Icon(
                                Icons.directions_car,
                                size: 60.0,
                              ),
                              const Icon(
                                Icons.pool,
                                size: 60.0,
                              ),
                              const Icon(
                                Icons.food_bank,
                                size: 60.0,
                              ),
                            ],
                          ),
                          color: Colors.blue[100],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Divider(
                          thickness: 5.0, // Adjust the thickness as needed
                          color: Colors.black, // Adjust the color as needed
                        ),

                        // Row(
                        //   children: [
                        //     Text(
                        //       '${productController2.imagesWithText[index]['harga']}',
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.bold, fontSize: 20),
                        //     ),
                        //     ElevatedButton(
                        //       style: ElevatedButton.styleFrom(
                        //         backgroundColor:
                        //             Color.fromARGB(255, 4, 133, 219),
                        //         minimumSize: Size(
                        //             140,
                        //              80), // Set minimum width and height
                        //       ),
                        //       onPressed: () {
                        //         Navigator.pushReplacement(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) => HotTripView()
                        //               ),
                        //         );
                        //       },
                        //       child: Padding(
                        //         padding: EdgeInsets.fromLTRB(
                        //             20,0,67,0), // Add 10-pixel padding on all sides
                        //         child: Align(
                        //           alignment: Alignment
                        //             .center, // Align the text to the left
                        //           child: Center(
                        //             child: Text(
                        //               "BOOK NOW",
                        //               style: TextStyle(
                        //                   fontSize: 25, color: Colors.black87),
                        //                   textAlign: TextAlign.center,

                        //             ),

                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        SizedBox(
                          height: 30,
                        ),

                        // Container(
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         child: Text(
                        //           '${productController2.imagesWithText[index]['harga']}',
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 20),
                        //         ),
                        //         margin: EdgeInsets.all(10),
                        //       ),
                        //       ElevatedButton(
                        //         style: ElevatedButton.styleFrom(
                        //           backgroundColor:
                        //               Color.fromARGB(255, 4, 133, 219),
                        //           minimumSize: Size(
                        //               180, 80), // Set minimum width and height
                        //         ),
                        //         onPressed: () {
                        //           Navigator.pushReplacement(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) => HotTripView()),
                        //           );
                        //         },
                        //         child: DecoratedBox(
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(50.0),
                        //           ),
                        //           child: Text(
                        //             "BOOK NOW",
                        //             style: TextStyle(
                        //                 fontSize: 25, color: Colors.black87),
                        //             textAlign: TextAlign.center,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        //   margin: EdgeInsets.fromLTRB(33, 0, 20, 0),
                        // ),
                      ],
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
