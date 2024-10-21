// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';



// class TrailInfoScreen extends StatelessWidget {
//   // Sample trail data with image URL
// final Map<String, dynamic> trailData = {
//   'name': 'Trail Name',
//   'difficulty': 4.5,
//   'length': '5 miles',
//   'review': {'rating': 4.8, 'count': 256},
//   'directions':
//       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
//   'image':  "https://media.istockphoto.com/id/146753772/photo/resort-in-cancun-shown-in-the-daytime-from-the-air.webp?b=1&s=170667a&w=0&k=20&c=4cHqeDSTKaMMKNSloU3JjB5fx-rrfI1lT2ASRrPLcB0=",
// };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Trail Information'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Image.network(
//               trailData['image'],
//               height: 200,
//               fit: BoxFit.cover,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     trailData['name'],
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Text(
//                         'Difficulty: ',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       RatingBarIndicator(
//                         rating: trailData['difficulty'],
//                         itemCount: 5,
//                         itemSize: 20.0,
//                         itemBuilder: (context, index) => Icon(
//                           Icons.star,
//                           color: Colors.amber,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Length: ${trailData['length']}',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Review: ${trailData['review']['rating']} (${trailData['review']['count']} reviews)',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Directions: ${trailData['directions']}',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
