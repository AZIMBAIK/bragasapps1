import 'package:bragasapps1/bragas_group/addToCartCloth.dart';
import 'package:bragasapps1/bragas_group/allPlaceOrderU2.dart';
import 'package:bragasapps1/bragas_group/allshopingOrder2U2.dart';
import 'package:bragasapps1/bragas_group/clothshopingU2.dart';
import 'package:bragasapps1/bragas_group/shoesShopU2.dart';
import 'package:flutter/material.dart';

class ShopingFirstPageU2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable debug mode banner
      home: ShoppingPage(),
    );
  }
}

class ShoppingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BRAGAS SHOPPING',style: TextStyle(fontWeight: FontWeight.bold,),),
        centerTitle: true,
        backgroundColor:  Colors.yellow,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 16.0),
            Container(
              height: 100.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  
                  SmallIconCard(
                    icon: Icons.shopping_cart,
                    text: 'Order',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ShippingHomePage()),
                      );
                    },
                  ),
                  // SmallIconCard(
                  //   icon: Icons.local_shipping, // Added shipping icon here
                  //   text: 'Shipping',
                  //   onTap: () {
                  //     // Add navigation logic for shipping
                  //   },
                  // ),
                  SmallIconCard(
                    icon: Icons.add_shopping_cart,
                    text: 'Add to Cart',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddToCartCloth(productData: {},)),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.0),
            BannerCard(
              imageUrl:
                  'https://media.istockphoto.com/id/957256814/photo/portrait-of-tattooed-young-man-with-black-t-shirt.jpg?s=612x612&w=is&k=20&c=ukXzoIAqhlPndfmx0OuYi-jlosTs-vaJmVINkTXEDZ8=',
              title: 'CLOTH ',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => clothShopU2()),
                );
              },
            ),
            SizedBox(height: 16.0),
            BannerCard(
              imageUrl:
                  'https://images.unsplash.com/photo-1460353581641-37baddab0fa2?q=80&w=871&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              title: 'SHOES ',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => shoesShopU2()),
                );
              },
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}


class SmallIconCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  const SmallIconCard({Key? key, required this.icon, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 32.0),
              SizedBox(height: 8.0),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}

class BannerCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final Function onTap;

  const BannerCard({Key? key, required this.imageUrl, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(imageUrl, fit: BoxFit.cover),
              Container(
                padding: EdgeInsets.all(12.0),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClothPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cloth Page')),
      body: Center(
        child: Text('This is the Cloth Page'),
      ),
    );
  }
}

class ShoesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shoes Page')),
      body: Center(
        child: Text('This is the Shoes Page'),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart Page')),
      body: Center(
        child: Text('This is the Cart Page'),
      ),
    );
  }
}

