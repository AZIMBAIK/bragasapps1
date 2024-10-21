import 'package:bragasapps1/Profile/viewOrderHistory.dart';
import 'package:bragasapps1/reusableWIdget/QImagePicker.dart';
import 'package:bragasapps1/reusableWIdget/Validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReceiptDetailsKasut {
  final String orderId;
  final String address;
  final String status;
  final String resit;
  final List<Map<String, dynamic>> orderDetails;

  ReceiptDetailsKasut({
    required this.orderId,
    required this.address,
    required this.status,
    required this.orderDetails,
    required this.resit,
  });
}

class DetailedReceiptPage extends StatelessWidget {
  final ReceiptDetailsKasut receipt;

  DetailedReceiptPage({required this.receipt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Order Page'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Information Details:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text('Order ID: ${receipt.orderId}'),
            Text('Address: ${receipt.address}'),
            Text('Status: ${receipt.status}'),
            SizedBox(height: 20.0),
            for (var item in receipt.orderDetails)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Product Name: ${item['productName']}'),
                  Text('Quantity: ${item['quantity']}'),
                  Text('Size: ${item['size']}'),
                  Text('Price: RM ${item['price']}'),
                  Text('Total Price: RM ${item['totalPrice']}'),
                  SizedBox(height: 10.0),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class ReceiptPageKasut extends StatefulWidget {
  final List<Map<String, dynamic>> orderDetails;

  ReceiptPageKasut({required this.orderDetails});

  @override
  _ReceiptPageKasutState createState() => _ReceiptPageKasutState();
}

class _ReceiptPageKasutState extends State<ReceiptPageKasut> {
  final _formKey = GlobalKey<FormState>();
  String _selectedStatus = 'Pending';
  String _address = '';
  String _resit = ''; // Use this class-level variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment order'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'INFORMATION DETAIL:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              for (var item in widget.orderDetails)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Product Name: ${item['productName']}'),
                    Text('Quantity: ${item['quantity']}'),
                    Text('Size: ${item['size']}'),
                    Text('Price: RM ${item['price']}'),
                    Text('Total Price: RM ${item['totalPrice']}'),
                    SizedBox(height: 10.0),
                  ],

              

                ),
              SizedBox(height: 20.0),

                          

              TextFormField(
                decoration: InputDecoration(labelText: 'Enter Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value ?? '';
                },
              ),
              SizedBox(height: 20.0),
              QImagePicker(
                label: "resit",
                validator: Validator.required,
                onChanged: (value) {
                  setState(() {
                    _resit = value; // Update the class-level variable
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                items: ['Pending']
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value ?? 'Pending';
                  });
                },
                decoration: InputDecoration(labelText: 'Select Status'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();

                    FirebaseFirestore firestore = FirebaseFirestore.instance;

                    DocumentReference orderRef = await firestore
                        .collection('order')
                        .add({
                      'address': _address,
                      'status': _selectedStatus,
                      'orderDetails': widget.orderDetails,
                      'timestamp': FieldValue.serverTimestamp(),
                      'resit': _resit, // Use the class-level variable
                    });

                    print('Order ID: ${orderRef.id}');

                    // Navigate to the AllReceiptsPage after storing data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => viewRegisterTripHistory(),
                      ),
                    );
                  }
                },
                child: Text('Make Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
