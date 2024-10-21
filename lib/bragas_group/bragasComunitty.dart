import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';



class bragasComunitty extends StatefulWidget {
  @override
  _bragasComunittyState createState() => _bragasComunittyState();
}

class _bragasComunittyState extends State<bragasComunitty> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Post> posts = [];
  TextEditingController captionController = TextEditingController();
  String? _selectedImagePath;

  @override
  void initState() {
    super.initState();
    // Fetch posts from Firestore and listen for updates
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('posts').get();

    setState(() {
      posts = snapshot.docs.map((doc) {
        return Post(
          id: doc.id,
          imagePath: doc['imagePath'],
          caption: doc['caption'],
          likes: doc['likes'],
          dateTime: doc['dateTime'].toDate(),
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text(
          'Community Activity',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostCard(post: posts[index], firestore: _firestore);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final pickedFile =
              await ImagePicker().pickImage(source: ImageSource.gallery);

          if (pickedFile != null) {
            setState(() {
              _selectedImagePath = pickedFile.path;
            });

            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Add a Post'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildImagePreview(),
                      SizedBox(height: 16),
                      TextField(
                        controller: captionController,
                        decoration: InputDecoration(labelText: 'Caption'),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (captionController.text.isNotEmpty) {
                          final newPost = Post(
                            imagePath: _selectedImagePath!,
                            caption: captionController.text,
                            likes: 0,
                            id: '',
                            dateTime: DateTime.now(),
                          );

                          _firestore.collection('posts').add({
                            'imagePath': newPost.imagePath,
                            'caption': newPost.caption,
                            'likes': newPost.likes,
                            'dateTime': newPost.dateTime,
                          });

                          setState(() {
                            posts.add(newPost);
                          });

                          captionController.clear();
                          _selectedImagePath = null;

                          Navigator.pop(context);
                        }
                      },
                      child: Text('Post'),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildImagePreview() {
    return Container(
      height: 150,
      width: double.infinity,
      color: Colors.grey[200],
      child: _selectedImagePath != null
          ? Image.file(
              File(_selectedImagePath!),
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            )
          : Icon(Icons.add_a_photo),
    );
  }
}

class Post {
  String imagePath;
  String caption;
  int likes;
  String id;
  DateTime dateTime;

 Post({
    required this.imagePath,
    required this.caption,
    required this.likes,
    required this.id,
    required this.dateTime,
  });
}


class PostCard extends StatelessWidget {
  final Post post;
  final FirebaseFirestore firestore;

  PostCard({required this.post, required this.firestore});

  @override
  Widget build(BuildContext context) {
     return Card(
      margin: EdgeInsets.all(8),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(
            File(post.imagePath),
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
           Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.favorite),
                      color: const Color.fromARGB(255, 119, 9, 2),
                      onPressed: () {
                        firestore
                            .collection('posts')
                            .doc(post.id)
                            .update({'likes': post.likes + 1});
                      },
                    ),
                    Text(
                      '${post.likes} Likes',
                      style: TextStyle(color: Colors.white,)),
                    
                    Spacer(),

                     IconButton(
                      icon: Icon(Icons.message),
                      color: Color.fromARGB(255, 254, 254, 254),
                      onPressed: () {
                        // firestore
                        //     .collection('posts')
                        //     .doc(post.id)
                        //     .update({'likes': post.likes + 1});
                      },
                    ),
                  ],
                ),






          if (post.caption.isNotEmpty)
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Caption:',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      post.caption,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4),
                // Row(
                //   children: [
                //     IconButton(
                //       icon: Icon(Icons.favorite),
                //       color: const Color.fromARGB(255, 119, 9, 2),
                //       onPressed: () {
                //         firestore
                //             .collection('posts')
                //             .doc(post.id)
                //             .update({'likes': post.likes + 1});
                //       },
                //     ),
                //     Text(
                //       '${post.likes} Likes',
                //       style: TextStyle(color: Colors.white,)),
                    
                //     Spacer(),
                //   ],
                // ),
                SizedBox(height: 4),
                Text(
                  'Date: ${_formattedDate(post.dateTime)}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String _formattedDate(DateTime dateTime) {
    DateTime now = DateTime.now();
    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return 'Today';
    } else {
      return '${dateTime.day}-${dateTime.month}-${dateTime.year}';
    }
  }
