
import 'package:bragasapps1/adminPart/AdminUpdateUserAccount';
import 'package:bragasapps1/allLoginPage/registerUserTripU2.dart';
import 'package:bragasapps1/bragas_group/AddProductShoes.dart';
import 'package:bragasapps1/bragas_group/PlanTripCalander.dart';
import 'package:bragasapps1/bragas_group/addProductFirsPageU2.dart';
import 'package:bragasapps1/bragas_group/addTrip.dart';
import 'package:bragasapps1/bragas_group/addToCartCloth.dart';
import 'package:bragasapps1/bragas_group/addtripFirstPage.dart';
import 'package:bragasapps1/bragas_group/allshopingOrder2U2.dart';
import 'package:bragasapps1/bragas_group/bragas%20_dashboard2.dart';
import 'package:bragasapps1/bragas_group/bragasUpdatePoster.dart';
import 'package:bragasapps1/adminPart/FetchProductHas2U2.dart';
import 'package:bragasapps1/bragas_group/clothshopingU2.dart';
import 'package:bragasapps1/bragas_group/FetchBuy.dart';
import 'package:bragasapps1/bragas_group/fetchDataAddToCart.dart';

import 'package:bragasapps1/core.dart';
import 'package:bragasapps1/firebase_options.dart';
import 'package:bragasapps1/hotTrip/userRegisterTrip.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

   await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
// navigatorKey: Get.navigatorKey,
debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        
      ),
          //  home: LoginPage2()
            //  home:Admin_dahboard2()
        home:Admin_dahboard2()
      // home: button_nav(context)
        // home: userRegisterTrip()
// AddTripFirstpage

//  home: ShippingHomePage()
  // home: Fetch2database()
    // home: UpdateTrip()
      // home:AddToCartCloth(productData: {},)
  // home: CalendarScreen()
        // home: AddProductShoes()
        // home: bragasUpdatePoster()
      // home: KaiDataDisplay()
   
      // home:ProductRegistrationForm ()
      
    //  home: LoginPage2()
        //  home: bragasDashboardMain()
      //  home: AddToCartUser(),
  
    );
  }
  
 

}