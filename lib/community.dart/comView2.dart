import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class comView2 extends StatefulWidget {
  @override
  _comView2State createState() => _comView2State();
}

class _comView2State extends State<comView2> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Post> posts = [];
  TextEditingController captionController = TextEditingController();
  String? _selectedImagePath;

  @override
  void initState() {
    super.initState();
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
          'Bragas Community ',
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
              io.File(_selectedImagePath!),
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
            io.File(post.imagePath),
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
                style: TextStyle(color: Colors.white),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.message),
                color: Color.fromARGB(255, 254, 254, 254),
                onPressed: () {
                  _showCommentBottomSheet(context);
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

  void _showCommentBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return CommentSection(post: post, firestore: firestore);
        });
  }
}

class CommentSection extends StatefulWidget {
  final Post post;
  final FirebaseFirestore firestore;

  CommentSection({required this.post, required this.firestore});

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController commentController = TextEditingController();
  List<Comment> comments = [];
  late String _currentUid;
  late String _currentUserName;
  late String _currentUserPhone;
  late String _currentUserProfileImagePath;

  @override
  void initState() {
    super.initState();
    _getCurrentUserData();
    _fetchComments();
  }

  Future<void> _getCurrentUserData() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DocumentSnapshot<Map<String, dynamic>> userDataSnapshot =
          await widget.firestore.collection('users').doc(user.uid).get();
      setState(() {
        _currentUid = user.uid;
        _currentUserName = userDataSnapshot['name'];
        _currentUserPhone = userDataSnapshot['phone'];
        _currentUserProfileImagePath = userDataSnapshot['profileImagePath'];
      });
    }
  }

  Future<void> _fetchComments() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await widget.firestore
        .collection('comments')
        .doc(widget.post.id)
        .collection('comments')
        .orderBy('dateTime', descending: true)
        .get();

    setState(() {
      comments = snapshot.docs.map((doc) {
        return Comment(
          text: doc['text'],
          dateTime: doc['dateTime'].toDate(),
          uid: doc['uid'],
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView(
              children: comments
                  .map((comment) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: _buildCommentItem(comment),
                      ))
                  .toList(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: commentController,
            decoration: InputDecoration(
              hintText: 'Type your comment...',
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: _addComment,
              ),
            ),
          ),
          // SizedBox(height: 16),
          // Text('Name: $_currentUserName'),
          // Text('Phone: $_currentUserPhone'),
          // Text('UID: $_currentUid'),
          // SizedBox(height: 16),
          // _buildProfileImage(),
        ],
      ),
    );
  }

 Widget _buildCommentItem(Comment comment) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CircleAvatar(
        radius: 16,
        backgroundColor: Colors.grey,
        backgroundImage: _currentUserProfileImagePath != null
            ? FileImage(File(_currentUserProfileImagePath!)) as ImageProvider<Object>
            : AssetImage('assets/avatar_placeholder.png') as ImageProvider<Object>,
      ),
      SizedBox(width: 8),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.uid == _currentUid ? _currentUserName : 'Other User',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              comment.text,
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 4),
            Text(
              _formattedDate(comment.dateTime),
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    ],
  );
}


  Widget _buildProfileImage() {
    return Container(
      height: 100,
      width: 110,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: _currentUserProfileImagePath != null
          ? Image.file(
              File(_currentUserProfileImagePath),
              height: 100,
              width: 110,
              fit: BoxFit.cover,
            )
          : Icon(Icons.person, size: 40),
    );
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

  void _addComment() async {
    if (commentController.text.isNotEmpty) {
      await widget.firestore
          .collection('comments')
          .doc(widget.post.id)
          .collection('comments')
          .add({
        'text': commentController.text,
        'dateTime': DateTime.now(),
        'uid': _currentUid,
        'userName': _currentUserName,
        'profileImagePath': _currentUserProfileImagePath,
      });

      _fetchComments();
      commentController.clear();
    }
  }
}

class Comment {
  String text;
  DateTime dateTime;
  String uid;

  Comment({required this.text, required this.dateTime, required this.uid});
}
// busuk 3