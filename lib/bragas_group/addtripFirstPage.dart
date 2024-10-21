import 'package:bragasapps1/bragas_group/PlanTripCalander.dart';
import 'package:bragasapps1/bragas_group/addTrip.dart';
import 'package:bragasapps1/bragas_group/updateTripU2.dart';
import 'package:flutter/material.dart';

class AddTripFirstpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Trip First Page',style:TextStyle(fontWeight: FontWeight.bold,)),
        centerTitle: true
        ,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardWidget(
              icon: Icons.calendar_today,
              label: 'Plan Trip calendar',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalendarScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            CardWidget(
              icon: Icons.directions_walk,
              label: 'Manage Poster Trip',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => addTrip(),
                  ),
                );                
              },
            ),
          
            SizedBox(height: 20),
            CardWidget(
              icon: Icons.update,
              label: 'Update Trip',
               onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateTrip(),
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
      height: 100,
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      size: 50,
                    ),
                    SizedBox(width: 10),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}

class AddClothScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Cloth'),
      ),
      body: Center(
        child: Text('Add Cloth Screen'),
      ),
    );
  }
}

class AddShoesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Shoes'),
      ),
      body: Center(
        child: Text('Add Shoes Screen'),
      ),
    );
  }
}
