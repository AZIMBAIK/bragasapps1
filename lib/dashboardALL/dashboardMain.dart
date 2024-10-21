import 'package:bragasapps1/hotTrip/ViewHotTrip.dart';
import 'package:bragasapps1/maping_All.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class dashMain extends StatefulWidget {
  const dashMain({Key? key}) : super(key: key);

  @override
  State<dashMain> createState() => _dash_view3State();
}

class _dash_view3State extends State<dashMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              // Background Image
              Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS37ksGepPo-dFdlBdo1Ze12uLBPPb53XsyvRZ7sjY1kw&s', // Replace with your image path
                fit: BoxFit.cover,
                width: double.infinity,
                height: 170,
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "EXPLORE NOW",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 245, 247, 248),
                          ),
                        ),
                      ],
                    ),
                    // color: Colors.black87.withOpacity(0.7),
                    padding: EdgeInsets.all(10),
                  ),
                  // Search bar

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(252, 120, 137, 236),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Color.fromARGB(248, 12, 12, 12),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                // Implement your search logic here
                                // Update the search results based on user input
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Rest of your widgets
                  // ...

                  // Row(
                  //   children: [
                  //     Container(
                  //       child: Row(
                  //         children: [
                  //           Text(
                  //             "TOP GROUP",
                  //             style: TextStyle(
                  //               fontSize: 30,
                  //               fontWeight: FontWeight.bold,
                  //               color: Colors.black87,
                  //             ),
                  //           ),
                  //           const Icon(
                  //             Icons.local_fire_department,
                  //             size: 40.0,
                  //             color: Colors.red,
                  //           ),
                  //           Expanded(
                  //             child: GestureDetector(
                  //               onTap: () {
                  //                 Navigator.of(context).push(MaterialPageRoute(
                  //                   builder: (context) => dashMain(),
                  //                 ));
                  //               },
                  //               child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment
                  //                     .end, // Align children to the right
                  //                 children: [
                  //                   Text(
                  //                     "view",
                  //                     style: TextStyle(fontSize: 20),
                  //                   ),
                  //                   const Icon(
                  //                     Icons.arrow_forward,
                  //                     size: 40.0,
                  //                     color: Colors.black87,
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       height: 70,
                  //       width: 390,
                  //     ),
                  //   ],
                  // ),
                 Card(
  elevation: 30, // Adjust the elevation for the shadow effect
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0), // Adjust the border radius as needed
  ),
  color: Colors.yellow[300],
  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
  child: SizedBox(
    width: MediaQuery.of(context).size.width * 2.0,
    height: 150,
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "City: $city",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Stormy: ${isStormy ? 'Yes' : 'No'}",
            style: TextStyle(
              color: isStormy ? Colors.red : Colors.green,
              fontSize: 16,
            ),
          ),
          Text(
            "Temperature: $temperature °C",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
            ),
          ),
          Text(
            "Weather Type: $weatherType",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  ),
),

                  // Builder(builder: (context) {
                  //   List images = [
                  //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdJS-WVL091ArpPdC8GwgLIOCkSYNwGfwEwA&usqp=CAU",
                  //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfyEfSyol5sXD3vQKNExdnHxsxlSUKSzm6fg&usqp=CAU",
                  //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3XbsuPYeuSzwd0snh0Pkli9LTGC6A1IvSxw&usqp=CAU",
                  //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUVW9xCB2ToTKlW-k-iaEilLPKThDkSVcfjw&usqp=CAU",
                  //   ];

                  //   return CarouselSlider(
                  //     options: CarouselOptions(
                  //       height: 110.0,
                  //       autoPlay: true,
                  //       enlargeCenterPage: true,
                  //     ),
                  //     items: images.map((imageUrl) {
                  //       return Builder(
                  //         builder: (BuildContext context) {
                  //           return Container(
                  //             width: MediaQuery.of(context).size.width,
                  //             margin:
                  //                 const EdgeInsets.symmetric(horizontal: 5.0),
                  //             decoration: BoxDecoration(
                  //               color: Colors.amber,
                  //               borderRadius: const BorderRadius.all(
                  //                 Radius.circular(16.0),
                  //               ),
                  //               image: DecorationImage(
                  //                 image: NetworkImage(
                  //                   imageUrl,
                  //                 ),
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //       );
                  //     }).toList(),
                  //   );
                  // }),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HotTripView(),
                              ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "HOT TRIP",
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(5, 172, 255, 1),
                                  ),
                                ),
                                const SizedBox(
                                    width:
                                        8), // Adding some space between text and icon
                                Icon(
                                  Icons.arrow_forward,
                                  size: 40.0,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // height: 70,
                        // width: 390,
                        // // margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                        // padding: EdgeInsets.all(21),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 230.0,
                                autoPlay: true,
                                enlargeCenterPage: true,
                              ),
                              items: CarouselData.imagesWithText.map((item) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(item['imageUrl']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Positioned(
                                            bottom: 120.0,
                                            child: Container(
                                              padding: EdgeInsets.all(10.0),
                                              color:
                                                  Color.fromRGBO(12, 12, 12, 1),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    item['kerunai'],
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      color: Color.fromRGBO(
                                                          250, 247, 247, 1),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    item['harga'],
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Color.fromRGBO(
                                                          250, 247, 247, 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
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

String city = 'KUALA LUMPUR'; // Replace with your actual city name
bool isStormy =
    false; // Replace with live data indicating if it's stormy or not
double temperature = 25.0; // Replace with live temperature data
String weatherType = 'Rain'; // Replace with live weather type data
