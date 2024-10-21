import 'dart:io';
import 'dart:typed_data';
import 'package:bragasapps1/bragas_group/insideBuyButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class clothShopU2 extends StatefulWidget {
  @override
  _clothShopU2State createState() => _clothShopU2State();
}

class _clothShopU2State extends State<clothShopU2> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Future<List<DocumentSnapshot>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _fetchProducts();
  }

  Future<List<DocumentSnapshot>> _fetchProducts() async {
    final QuerySnapshot querySnapshot =
        await _firestore.collection('products').get();
    return querySnapshot.docs;
  }

  Future<List<Map<String, dynamic>>> _fetchProductDetails(
      String productId) async {
    final DocumentSnapshot productDoc =
        await _firestore.collection('products').doc(productId).get();
    List<dynamic> details = productDoc['details'];
    return List<Map<String, dynamic>>.from(details);
  }

  Future<Uint8List?> _getImage(String imagePath) async {
    File imageFile = File(imagePath);
    if (imageFile.existsSync()) {
      return await imageFile.readAsBytes();
    }
    return null;
  }

  double _getCardHeight(int index) {
    // Make right cards taller than left cards
    return index % 2 == 0 ? 250.0 : 250.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cloth Shop',style: TextStyle(fontWeight: FontWeight.bold,),),
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              color: Colors.blue,
              child: Stack(
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1563754737980-501f23636f7c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8aGlraW5nJTIwbWFufGVufDB8fDB8fHww',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Positioned(
                    bottom: 250,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 50,
                      color: Colors.yellow,
                      alignment: Alignment.center,
                      child: Text(
                        'BRAGAS CLOTH',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
               
                ],
              ),
            ),
          
            FutureBuilder(
              future: _productsFuture,
              builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error fetching data'));
                } else {
                  final products = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) =>
                          _buildProductCard(products[index], index),
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(DocumentSnapshot product, int index) {
    String productId = product.id;
    String imagePath = product['imagePath'] ?? '';
    String productName = product['productName'] ?? '';

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _fetchProductDetails(productId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading product details'));
        } else {
          final productDetails = snapshot.data!;
          return InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) => ProductBottomSheet(
                  productName: productName,
                  productDetails: productDetails,
                  imagePath: imagePath,
                  productId: productId, // Pass productId to ProductBottomSheet
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(color: Colors.black, width: 1.0),
              ),
              child: Container(
                height: _getCardHeight(index),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: FutureBuilder<Uint8List?>(
                        future: _getImage(imagePath),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error loading image'));
                          } else {
                            return ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                              ),
                              child: Image.memory(
                                snapshot.data!,
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.0),
                          Text(
                            productName,
                            style: TextStyle(fontSize: 16,  fontWeight: FontWeight.bold,color: Colors.grey[600],),
                          ),
                          // SizedBox(height: 3.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ' \RM${productDetails[0]['price'].toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                 fontWeight: FontWeight.bold
                                 ),
                              ),
                            ],
                          ),
                       
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}












class ProductBottomSheet extends StatefulWidget {
  final String productName;
  final List<Map<String, dynamic>> productDetails;
  final String imagePath;
  final String productId;

  ProductBottomSheet({
    required this.productName,
    required this.productDetails,
    required this.imagePath,
    required this.productId,
  });

  @override
  _ProductBottomSheetState createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ProductBottomSheet> {
  late Map<String, dynamic> selectedSizeDetails;
  int quantity = 1; // Initial quantity

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void buyProduct() async {
    // Calculate new limit based on quantity purchased
    int newLimit = selectedSizeDetails['limit'] - quantity;

    if (newLimit <= 0) {
      // Show a dialog indicating no stock available
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Stock Available'),
            content: Text('The selected size is out of stock.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Update the product limit in the database
      await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.productId)
          .update({'details': FieldValue.arrayRemove([selectedSizeDetails])});

      selectedSizeDetails['limit'] = newLimit;

      await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.productId)
          .update({'details': FieldValue.arrayUnion([selectedSizeDetails])});

      // Navigate to BuyScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BuyScreen(
            productName: widget.productName,
            selectedSize: selectedSizeDetails['size'],
            selectedPrice: selectedSizeDetails['price'].toDouble(),
            quantity: quantity,
            imagePath: widget.imagePath,
          ),
        ),
      );
    }
  }

 void addToCart() async {
  // Prepare data to be added to cart
  Map<String, dynamic> cartItem = {
    'productName': widget.productName,
    'selectedSize': selectedSizeDetails['size'],
    'selectedPrice': selectedSizeDetails['price'].toDouble(),
    'quantity': quantity,
    'imagePath': widget.imagePath,
    'uid': FirebaseAuth.instance.currentUser!.uid, // Record UID of the current user
    // Add more fields as needed
  };

  // Calculate the new limit
  int newLimit = selectedSizeDetails['limit'] - quantity;

  // Ensure that the new limit is greater than or equal to 0
  if (newLimit >= 0) {
    try {
      // Update the product limit in Firestore
      await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.productId)
          .update({
        'details': FieldValue.arrayRemove([selectedSizeDetails])
      });

      selectedSizeDetails['limit'] = newLimit;

      await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.productId)
          .update({
        'details': FieldValue.arrayUnion([selectedSizeDetails])
      });

      // Save cart item to Firestore collection
      await FirebaseFirestore.instance
          .collection('cloth_product_add_to_cart')
          .add(cartItem);
      
      // Show a snackbar indicating successful addition to cart
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product added to cart successfully.'),
          duration: Duration(seconds: 2),
        ),
      );

      print('Product added to cart!');
      print('Product limit updated successfully!');
    } catch (e) {
      print('Error updating product limit: $e');
    }
  } else {
    // Show a snackbar indicating no stock available
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('No stock available for this size.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Close the bottom sheet
  Navigator.pop(context);
}


  @override
  void initState() {
    super.initState();
    selectedSizeDetails = widget.productDetails[0]; // Set initial selected size details
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.productName,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Text(
            'RM${(selectedSizeDetails['price'].toDouble() * quantity).toStringAsFixed(2)}', // Update price based on quantity
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16.0),
          Text(
            'Available Sizes:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(
              widget.productDetails.length,
              (index) {
                final detail = widget.productDetails[index];
                final size = detail['size'];
                final limit = detail['limit'];
                final price = detail['price'].toDouble();
                final isSelected = size == selectedSizeDetails['size'];
                return IgnorePointer(
                  ignoring: limit <= 0, // Disable interactions when limit is 0 or less
                  child: InkWell(
                    onTap: () {
                      if (limit > 0) {
                        setState(() {
                          selectedSizeDetails = detail;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.yellow[100] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: isSelected ? Colors.yellow : Colors.transparent, width: 2.0),
                      ),
                      child: Column(
                        children: [
                          Text(size),
                          Text('Limit: $limit'), // Display limit below size
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              IconButton(
                onPressed: decreaseQuantity,
                icon: Icon(Icons.remove),
              ),
              Text('$quantity'),
              IconButton(
                onPressed: increaseQuantity,
                icon: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  width: 50,
                  child: ElevatedButton(
                    onPressed: buyProduct,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text('Buy'),
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Container(
                  width: 50,
                  child: ElevatedButton(
                    onPressed: addToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                    ),
                    child: Text('Add to Cart'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
//PADUNYA CLOTH