import 'package:flutter/material.dart';
import 'package:bragasapps1/bragas_group/AddProductShoes.dart';
import 'package:bragasapps1/bragas_group/addProductCloth.dart';

class addProductFirsPageU2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product',style:TextStyle(fontWeight: FontWeight.bold,),),
        centerTitle: true
        ,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardWidget(
              icon: Icons.shopping_bag,
              label: 'Add Cloth',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProductCloth(),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            CardWidget(
              icon: Icons.directions_walk,
              label: 'Add Shoes',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProductShoes(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const CardWidget({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 150,
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: onPressed,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(
                  icon,
                  size: 60,
                ),
              ),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward),
            ],
          ),
        ),
      ),
    );
  }
}
