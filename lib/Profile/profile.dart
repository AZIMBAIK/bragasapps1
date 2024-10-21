import 'package:bragasapps1/maping_All.dart';
import 'package:bragasapps1/state_util.dart';
import 'package:flutter/material.dart';


class MainProfile extends StatefulWidget {
  const MainProfile({Key? key}) : super(key: key);
  

  @override
  State<MainProfile> createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  Profile productController2 = Profile();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      SizedBox(width: 120),
                      Container(
                        child: Text(
                          "PROFILE",
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        height: 40,
                      ),
                    ],
                  ),
                  color: Colors.black87,
                ),
                // ... rest of your code ...

                for (var item in productController2.profileitem)
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        item["label"],
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        size: 24.0,
                      ),
                      onTap: () {
                        Get.to(item["view"]);
                      },
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
