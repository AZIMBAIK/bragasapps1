import 'package:bragasapps1/hotTrip/nextPageviewMountain.dart';
import 'package:bragasapps1/maping_All.dart';
import 'package:flutter/material.dart';

class mountview1 extends StatefulWidget {
  const mountview1({Key? key});

  @override
  State<mountview1> createState() => _mountview1State();
}

class _mountview1State extends State<mountview1> {
  MountMap productController2 = MountMap();

  void _navigateToLpsTknn(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            nextPageViewMountain(index: index), // Pass the index as a parameter
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1.0,
        crossAxisCount: 2,
        crossAxisSpacing: 3, // You can change this value to fit your design
      ),
      itemCount: productController2.imagesWithText.length,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        var item = productController2.imagesWithText[index];
        return GestureDetector(
          onTap: () {
            _navigateToLpsTknn(index); // Pass the index when tapping
          },
          child: Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(item['imageUrl']),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(6.0),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 6.0,
                          top: 8.0,
                          child: CircleAvatar(
                            radius: 14.0,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  item['kerunai'],
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                // Text(
                //   item['harga'],
                //   style: TextStyle(
                //     fontSize: 16.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
            margin: EdgeInsets.fromLTRB(10, 0, 3, 0),
          ),
        );
      },
    );
  }
}
