import 'package:bragasapps1/shoopingAll/resitBaju.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  CartPage(this.cartItems);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    double totalPriceToPay = 0;

    // Calculate the total price to pay
    for (var item in widget.cartItems) {
      totalPriceToPay += item['totalPrice'].toDouble();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart',style: TextStyle(fontWeight: FontWeight.bold,),),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                var item = widget.cartItems[index];
                final productName = item['productName'];
                final int quantity = item['quantity'];
                final int price = item['price'];
                final int totalPrice = item['totalPrice'];
                final String assetPath = item['assetPath'];
                final String size = item['size'];

                return Card(
                  elevation: 5.0,
                    margin: EdgeInsets.fromLTRB(70, 30, 70, 20),
                    
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                             
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
                            height: 150, 
                            width: 600,// Adjust the height as needed
                          ),
                          Positioned(
                          
                            top: 10.0,
                            child: IconButton(
                              icon: Icon(
                                Icons.remove_shopping_cart,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                // Implement logic to remove the item from the cart
                                setState(() {
                                  widget.cartItems.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ],
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
                                'RM $price',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Quantity: $quantity',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Size: $size', // Display the size here
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                'Total Price: RM $totalPrice',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  'Total Price to Pay: RM ${totalPriceToPay.round()}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
               ElevatedButton(
  onPressed: () {
    // Navigate to the ReceiptPage and pass order details
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReceiptPageBaju(orderDetails: widget.cartItems),
      ),
    );
  },
  child: Text('Proceed to Payment'),
),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
