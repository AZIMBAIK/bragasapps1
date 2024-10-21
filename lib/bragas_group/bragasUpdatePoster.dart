// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';

// class bragasUpdatePoster extends StatefulWidget {
//   @override
//   _bragasUpdatePosterState createState() => _bragasUpdatePosterState();
// }

// class _bragasUpdatePosterState extends State<bragasUpdatePoster> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   List<Post> posts = [];
//   TextEditingController captionController = TextEditingController();
//   String? _selectedImagePath;

//   @override
//   void initState() {
//     super.initState();
//     // Fetch posts from Firestore and listen for updates
//     _fetchPosts();
//   }

//   Future<void> _fetchPosts() async {
//     final QuerySnapshot<Map<String, dynamic>> snapshot =
//         await _firestore.collection('update Poster').get();

//     setState(() {
//       posts = snapshot.docs.map((doc) {
//         return Post(
//           id: doc.id,
//           imagePath: doc['imagePath'],
//         );
//       }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
  
//       body: ListView.builder(
//         itemCount: posts.length,
//         itemBuilder: (context, index) {
//           return PostCard(post: posts[index], onDelete: () => _deletePost(index));
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           // Use image_picker to pick an image from the device
//           final pickedFile =
//               await ImagePicker().pickImage(source: ImageSource.gallery);

//           if (pickedFile != null) {
//             setState(() {
//               _selectedImagePath = pickedFile.path;
//             });

//             showDialog(
//               context: context,
//               builder: (context) {
//                 return AlertDialog(
//                   title: Text('Add a Post'),
//                   content: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       _buildImagePreview(),
//                     ],
//                   ),
//                   actions: [
//                     TextButton(
//                       onPressed: () {
//                         // Close the dialog
//                         Navigator.pop(context);
//                       },
//                       child: Text('Cancel'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         // Add the new post to the list
//                         final newPost = Post(
//                           imagePath: _selectedImagePath!,
//                           id: '',
//                         );

//                         // Save post data to Firestore
//                         _firestore.collection('update Poster').add({
//                           'imagePath': newPost.imagePath,
//                         });

//                         setState(() {
//                           posts.add(newPost);
//                         });

//                         // Clear the image path
//                         _selectedImagePath = null;

//                         // Close the dialog
//                         Navigator.pop(context);
//                       },
//                       child: Text('Post'),
//                     ),
//                   ],
//                 );
//               },
//             );
//           }
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   Widget _buildImagePreview() {
//     return Container(
//       height: 150,
//       width: double.infinity,
//       color: Colors.grey[200],
//       child: _selectedImagePath != null
//           ? Image.file(
//               File(_selectedImagePath!),
//               height: 150,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             )
//           : Icon(Icons.add_a_photo),
//     );
//   }

//   Future<void> _deletePost(int index) async {
//     final postId = posts[index].id;

//     if (postId.isNotEmpty) {
//       // Remove the post from Firestore
//       await _firestore.collection('update Poster').doc(postId).delete();

//       setState(() {
//         posts.removeAt(index);
//       });
//     }
//   }
// }

// class Post {
//   String imagePath;
//   String id;

//   Post({required this.imagePath, required this.id});
// }

// class PostCard extends StatelessWidget {
//   final Post post;
//   final VoidCallback onDelete;

//   PostCard({required this.post, required this.onDelete});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Card(
//         margin: EdgeInsets.all(8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.file(
//               File(post.imagePath),
//               height: 500,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//             SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: onDelete,
//               child: Text('Delete'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
