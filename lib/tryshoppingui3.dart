import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class usertryshop extends StatefulWidget {
  @override
  _usertryshopState createState() => _usertryshopState();
}

class _usertryshopState extends State<usertryshop> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late int _selectedSize;
  late Map<String, int> _quantities; // Map to store quantities for each product
  late Map<String, double> _totalPurchases; // Map to store total purchases for each product
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _selectedSize = 0;
    _quantities = {}; // Initialize the map
    _totalPurchases = {}; // Initialize the map
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Interface'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _firestore.collection('products').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<DocumentSnapshot> products = snapshot.data!.docs;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return _buildProductCard(products[index]);
              },
            );
          }
        },
      ),
    );
  }

  Future<void> _buyProduct(DocumentSnapshot productSnapshot, int selectedSize, int quantity) async {
    try {
      Map<String, dynamic> productData = productSnapshot.data() as Map<String, dynamic>;
      int currentLimit = productData['size$selectedSize']['limit'] as int;
      if (currentLimit >= quantity) {
        await productSnapshot.reference.update({'size$selectedSize.limit': currentLimit - quantity});
        double price = double.parse(productData['size$selectedSize']['price'].toString());
        double totalPriceIncrement = price * quantity;
        _totalPrice += totalPriceIncrement;

        // Update total purchase for the product
        String productId = productSnapshot.id;
        if (!_totalPurchases.containsKey(productId)) {
          _totalPurchases[productId] = 0.0; // Initialize total purchase
        }
        _totalPurchases[productId] = (_totalPurchases[productId] ?? 0.0) + totalPriceIncrement;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product bought successfully!'),
          ),
        );
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Not enough stock for size $selectedSize!'),
          ),
        );
      }
    } catch (e) {
      print('Error buying product: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error buying product: $e'),
        ),
      );
    }
  }

  Widget _buildProductCard(DocumentSnapshot productSnapshot) {
    String productId = productSnapshot.id;
    if (!_quantities.containsKey(productId)) {
      _quantities[productId] = 1; // Initialize quantity for new product card
    }
    int quantity = _quantities[productId]!;

    return StreamBuilder<DocumentSnapshot>(
      stream: productSnapshot.reference.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          Map<String, dynamic> productData = snapshot.data!.data() as Map<String, dynamic>;
          List<int> sizes = productData.keys
              .where((key) => key.startsWith('size'))
              .map((key) => int.tryParse(key.substring(4)) ?? 0)
              .toList();
          sizes.sort();

          int selectedSize = _selectedSize;
          if (!sizes.contains(selectedSize)) {
            selectedSize = sizes.isNotEmpty ? sizes[0] : 0;
          }

          int currentLimit = productData['size$selectedSize']['limit'] as int;
          double price = double.parse(productData['size$selectedSize']['price'].toString());

          // Calculate total purchase for the product
          double totalPurchase = _totalPurchases[productId] ?? 0.0;

          // Retrieve image URL from the Firestore document
          String? imageUrl = productData['image'];

          return Card(
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display the image using Image.network if imageUrl is not null or empty
                  if (imageUrl != null && imageUrl.isNotEmpty)
                    Image.network(
                      imageUrl,
                      height: 100, // Adjust height as needed
                      width: double.infinity, // Take full width
                      fit: BoxFit.cover, // Adjust the image fit
                    )
                  else
                    Placeholder(), // Placeholder if no image URL is available
                  SizedBox(height: 8),
                  Text(
                    'Product Name: ${productData['name']}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Select Size:'),
                  DropdownButton<int>(
                    value: selectedSize,
                    onChanged: (newSize) {
                      setState(() {
                        _selectedSize = newSize ?? 0;
                      });
                    },
                    items: sizes.map((size) {
                      return DropdownMenuItem<int>(
                        value: size,
                        child: Text('Size $size'),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              _quantities[productId] = quantity - 1;
                              _calculateTotalPurchase(price, productId);
                            });
                          }
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Text('Quantity: $quantity'),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _quantities[productId] = quantity + 1;
                            _calculateTotalPurchase(price, productId);
                          });
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('Price: $price'),
                  Text('Limit: $currentLimit'),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      _buyProduct(productSnapshot, selectedSize, quantity);
                    },
                    child: Text('Buy'),
                  ),
                  SizedBox(height: 8),
                  Text('Total Purchase below Limit: $totalPurchase'),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  void _calculateTotalPurchase(double price, String productId) {
    // Calculate total purchase for the product
    _totalPurchases[productId] = _quantities[productId]! * price;
  }
}
