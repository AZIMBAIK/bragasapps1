import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class bragasMaintence3ui extends StatefulWidget {
  @override
  _bragasMaintence3uiState createState() => _bragasMaintence3uiState();
}

class _bragasMaintence3uiState extends State<bragasMaintence3ui> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Maintenance'),
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

  Future<void> _deleteProduct(DocumentSnapshot productSnapshot) async {
    try {
      await productSnapshot.reference.delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product deleted successfully!'),
        ),
      );
      setState(() {}); // Update UI after deleting
    } catch (e) {
      print('Error deleting product: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting product: $e'),
        ),
      );
    }
  }

  Future<void> _updateProduct(DocumentSnapshot productSnapshot) async {
    // Implement the logic to update the product data here
    // You can show a dialog or navigate to a new screen to allow the user to update the data
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Product'),
        content: Text('Here you can update product information.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Implement the logic to update the product data
              // This could involve updating the Firestore document
              Navigator.of(context).pop();
            },
            child: Text('Update'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(DocumentSnapshot productSnapshot) {
    return StreamBuilder<DocumentSnapshot>(
      stream: productSnapshot.reference.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          Map<String, dynamic>? productData = snapshot.data?.data() as Map<String, dynamic>?;

          if (productData == null) {
            return Text('Product data not available');
          }

          List<int> sizes = productData.keys
              .where((key) => key.startsWith('size'))
              .map((key) => int.tryParse(key.substring(4)) ?? 0)
              .toList();
          sizes.sort();

          int selectedSize = sizes.isNotEmpty ? sizes[0] : 0;

          return Card(
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        selectedSize = newSize!;
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
                  Text('Price: ${productData['size$selectedSize']['price']}'),
                  Text('Limit: ${productData['size$selectedSize']['limit']}'),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _deleteProduct(productSnapshot);
                        },
                        child: Text('Delete'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _updateProduct(productSnapshot);
                        },
                        child: Text('Update'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
