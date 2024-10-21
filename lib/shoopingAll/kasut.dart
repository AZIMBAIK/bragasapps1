import 'package:bragasapps1/maping_All.dart';
import 'package:bragasapps1/shoopingAll/chartbaju.dart';

import 'package:flutter/material.dart';

class Kasut extends StatefulWidget {
  @override
  State<Kasut> createState() => _KasutState();
}

class _KasutState extends State<Kasut> {
  Kasutshop productController = Kasutshop();
  Map<String, int> productQuantity = {};
  List<Map<String, dynamic>> cartItems = [];
  String selectedSize = "39"; // Default size value

  int calculateTotalQuantity() {
    int totalQuantity = 0;
    productQuantity.forEach((key, value) {
      totalQuantity += value;
    });
    return totalQuantity;
  }

  int calculateTotalPrice() {
    int totalPrice = 0;
    productQuantity.forEach((key, value) {
      var product = productController.kasutshop.firstWhere((element) => element["k"] == key);
      int price = product["harga"];
      totalPrice += (price * value);
    });
    return totalPrice;
  }

  void updateQuantity(String productName, int quantity) {
    setState(() {
      if (quantity > 0) {
        productQuantity[productName] = quantity;
      } else {
        productQuantity.remove(productName);
      }
    });
  }

  void addToCart(String productName, int quantity, int price, String assetPath, String selectedSize) {
    setState(() {
      cartItems.add({
        'productName': productName,
        'quantity': quantity,
        'price': price,
        'totalPrice': quantity * price,
        'assetPath': assetPath,
        'size': selectedSize,
      });
    });
  }

  void checkout() {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(cartItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor:  Colors.yellow,
          title: Text('KASUT',style: TextStyle(fontWeight: FontWeight.bold,),),
        ),
        body: ListView.builder(
          itemCount: productController.kasutshop.length,
          itemBuilder: (BuildContext context, int index) {
            var item = productController.kasutshop[index];
            final productName = item["k"];
            final int productPrice = item["harga"];
            final assetPath = item["assetPath"];

            final quantity = productQuantity.containsKey(productName)
                ? productQuantity[productName]
                : 0;

            return Card(
              elevation: 5.0,
              margin: EdgeInsets.fromLTRB(70, 30, 70, 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      updateQuantity(productName, quantity! + 1);
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(assetPath),
                          fit: BoxFit.contain,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10.0,
                          ),
                        ),
                      ),
                      height: 150, // Adjust the height as needed
                      child: Stack(
                        children: [
                          Positioned(
                            right: 20.0,
                            top: 20.0,
                            child: CircleAvatar(
                              radius: 14.0,
                              backgroundColor: Colors.black,
                              child: Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 20.0,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            productName,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'RM $productPrice',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          // Size dropdown field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'Size',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DropdownButtonFormField(
                                items: [
                                  {
                                    "label": "37",
                                    "value": "37",
                                  },
                                  {
                                    "label": "38",
                                    "value": "38",
                                  },
                                  {
                                    "label": "39",
                                    "value": "39",
                                  },
                                    {
                                    "label": "40",
                                    "value": "40",
                                  },
                                  {
                                    "label": "41",
                                    "value": "41",
                                  },
                                  {
                                    "label": "42",
                                    "value": "42",
                                  },
                                  
                                ].map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item['label']!),
                                    value: item['value'],
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedSize = newValue.toString();
                                  });
                                },
                                value: selectedSize,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a size';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  updateQuantity(productName, quantity! - 1);
                                },
                                icon: Icon(Icons.remove),
                              ),
                              Center(
                                child: Text(
                                  '$quantity',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  updateQuantity(productName, quantity! + 1);
                                },
                                icon: Icon(Icons.add),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          ElevatedButton(
                            onPressed: () {
                              addToCart(productName, quantity!, productPrice, assetPath, selectedSize);
                            },
                            child: Text('Add to Cart'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        // Total container at the bottom
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Total Quantity: ${calculateTotalQuantity()}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text(
                'Total Price: RM ${calculateTotalPrice()}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              ElevatedButton(
                onPressed: checkout,
                child: Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
