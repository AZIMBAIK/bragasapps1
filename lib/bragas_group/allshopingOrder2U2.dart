import 'package:bragasapps1/bragas_group/allSecussfullOrder.dart';
import 'package:bragasapps1/bragas_group/allShippingU2.dart';
import 'package:flutter/material.dart';
import 'package:bragasapps1/bragas_group/allPlaceOrderU2.dart';

class ShippingHomePage extends StatefulWidget {
  @override
  _ShippingHomePageState createState() => _ShippingHomePageState();
}

class _ShippingHomePageState extends State<ShippingHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shipping Interface'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.add_shopping_cart),
              text: 'Place Order',
            ),
            Tab(
              icon: Icon(Icons.local_shipping),
              text: 'Shipping',
            ),
            Tab(
              icon: Icon(Icons.check_circle),
              text: 'Successful Orders',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          allPlaceOrderU2(),
          allShippingOrderU2(),
          allSecussfullOrder(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class ShippingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Shipping Page'),
    );
  }
}

class SuccessfulOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Successful Orders Page'),
    );
  }
}
