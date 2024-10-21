import 'package:bragasapps1/hotTrip/userRegisterTrip.dart';
import 'package:bragasapps1/module/registertrip_form5/view/registertrip_form5_view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class realTodayTripView extends StatefulWidget {
  @override
  _realTodayTripViewState createState() => _realTodayTripViewState();
}

class _realTodayTripViewState extends State<realTodayTripView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _firestore.collection('adminPostPoster').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No data available'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var document = snapshot.data!.docs[index];
              var imagePath = document['imagePath'] ?? '';

              return PosterCard(imagePath: imagePath);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => userRegisterTrip()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class PosterCard extends StatelessWidget {
  final String imagePath;

  PosterCard({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(
            File(imagePath),
            height: 600,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 8),
          // Add other details if needed
        ],
      ),
    );
  }
}



