// import 'package:flutter/material.dart';



// class ComView extends StatelessWidget {
//   final List<String> imageUrls = [
//     'https://media.istockphoto.com/id/1341288649/photo/75mpix-panorama-of-beautiful-mount-ama-dablam-in-himalayas-nepal.webp?b=1&s=170667a&w=0&k=20&c=4NKz9veFo5-po92H0ZQ1FGoxMec7DaBPsaj9dZvp9rE=',
//     'https://media.istockphoto.com/id/1496108471/photo/the-matterhorn-mountain-peaks-are-reflected-in-the-lake.webp?b=1&s=170667a&w=0&k=20&c=8SqqG4ilzE-K0hGmxk5clYesEeGLFJ6p_3Jn7PvabPw=',
//     'https://media.istockphoto.com/id/1320549628/photo/camper-travels-along-a-curving-highway-in-alaska-below-mountains-near-seward-on-a-sunny.webp?b=1&s=170667a&w=0&k=20&c=7HfIEFiFS90iZvc_vcQGlP3xwAkpp_LYcLjpYGozSCA=',
//     'https://media.istockphoto.com/id/1756133188/photo/view-of-fishermen-fishing-on-river-in-thung-mountain-in-tra-linh-cao-bang-province-vietnam.webp?b=1&s=170667a&w=0&k=20&c=OwHGik0lokvQQH-5xapzJtvPUEUwvLETznO-HKRCPP4=',
//     'https://media.istockphoto.com/id/485371557/photo/twilight-at-spirit-island.webp?b=1&s=170667a&w=0&k=20&c=vpytXwo5d2YieC64i67aH9D0L5x-4Uow8GbpzuonCIY=',
//     'https://media.istockphoto.com/id/1426559579/photo/female-tourist-enjoying-watching-hot-air-balloons-flying-in-the-sky-at-rooftop-of-hotel-where.jpg?s=612x612&w=0&k=20&c=Qt1uOy5rkPhX1siH8yKEQ-JwjQJpiKa5XBqcNnMrsb8=',
//     'https://media.istockphoto.com/id/1432956286/photo/aerial-view-of-beautiful-orange-trees-on-the-hill-and-mountains-in-low-clouds-at-sunrise-in.webp?b=1&s=170667a&w=0&k=20&c=lCyNzY-vKkI-FTeB2XESL8rk-SsL-SxNHoZF2yc5eBM=',
//     // Add more image URLs here...
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 1, // Number of grid columns
//         crossAxisSpacing: 8.0,
//         mainAxisSpacing: 8.0,
//       ),
//       itemCount: imageUrls.length,
//       itemBuilder: (BuildContext context, int index) {
//         return SocialMediaPost(imageUrl: imageUrls[index]);
//       },
//     );
//   }
// }

// class SocialMediaPost extends StatelessWidget {
//   final String imageUrl;

//   const SocialMediaPost({required this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         double imageHeight = MediaQuery.of(context).size.width * 0.7; // Adjust this ratio as needed
//         return Card(
//           elevation: 4,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Image.network(
//                 imageUrl,
//                 fit: BoxFit.cover,
//                 height: imageHeight,
//                 width: double.infinity,
//               ),
//               SizedBox(height: 8),
//               Row(
//                 children: <Widget>[
//                   IconButton(
//                     icon: Icon(Icons.thumb_up),
//                     onPressed: () {
//                       // Add your like functionality here
//                     },
//                   ),
//                   Text('Like'), // Show like count here
//                   SizedBox(width: 16),
//                   IconButton(
//                     icon: Icon(Icons.comment),
//                     onPressed: () {
//                       // Add your comment functionality here
//                     },
//                   ),
//                   Text('Comment'), // Show comment count here
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
