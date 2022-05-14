// import 'package:flutter/material.dart';
// import 'package:muslim_gap_app/views/post.dart';
// import 'package:muslim_gap_app/functionality/wp-api.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class PostTile extends StatefulWidget {
//   final String imageApiUrl, title, desc, excerpt;
//   const PostTile(
//       {Key? key,
//       required this.imageApiUrl,
//       required this.title,
//       required this.desc,
//       required this.excerpt})
//       : super(key: key);

//   @override
//   _PostTileState createState() => _PostTileState();
// }

// class _PostTileState extends State<PostTile> {
//   String imageUrl = "";

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PostPage(
//               title: widget.title,
//               imageUrl: imageUrl,
//               desc: widget.desc,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         height: 300,
//         padding: const EdgeInsets.only(right: 50, left: 50, top: 25, bottom: 5),
//         constraints: const BoxConstraints(maxHeight: 350),
//         decoration: BoxDecoration(
//             color: const Color.fromARGB(255, 41, 45, 51),
//             border: Border.all(width: 7, color: Colors.white70),
//             borderRadius: BorderRadius.circular(30),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.white.withOpacity(0.5),
//                   offset: const Offset(0, 16),
//                   blurRadius: 3,
//                   spreadRadius: -9),
//             ]),
//         child: SizedBox(
//           child: Column(children: [
//             Center(
//               child: Text(
//                 widget.title,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontFamily: "Raleway",
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Center(
//               child: FutureBuilder(
//                   future: fetchWpPostImageUrl(widget.imageApiUrl),
//                   builder: (context, AsyncSnapshot snapshot) {
//                     if (snapshot.hasData) {
//                       imageUrl = snapshot.data["guid"]["rendered"];
//                       return Center(
//                         child: CachedNetworkImage(
//                           height: 100,
//                           imageUrl: imageUrl,
//                           placeholder: (context, url) =>
//                               const LinearProgressIndicator(),
//                           errorWidget: (context, url, error) =>
//                               const Icon(Icons.error),
//                         ),
//                       );
//                     }
//                     return const CircularProgressIndicator();
//                   }),
//             ),
//             Expanded(
//               child: Center(
//                 child: Text(
//                   widget.excerpt,
//                   style: const TextStyle(
//                     fontFamily: "Raleway",
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:muslim_gap_app/views/post.dart';
// import 'package:muslim_gap_app/functionality/wp-api.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class PostTile extends StatefulWidget {
//   final String imageApiUrl, title, desc, excerpt;
//   const PostTile(
//       {Key? key,
//       required this.imageApiUrl,
//       required this.title,
//       required this.desc,
//       required this.excerpt})
//       : super(key: key);

//   @override
//   _PostTileState createState() => _PostTileState();
// }

// class _PostTileState extends State<PostTile> {
//   String imageUrl = "";

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PostPage(
//               title: widget.title,
//               imageUrl: imageUrl,
//               desc: widget.desc,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         height: 300,
//         padding: const EdgeInsets.only(right: 50, left: 50, top: 25, bottom: 5),
//         constraints: const BoxConstraints(maxHeight: 350),
//         decoration: BoxDecoration(
//             color: const Color.fromARGB(255, 41, 45, 51),
//             border: Border.all(width: 7, color: Colors.white70),
//             borderRadius: BorderRadius.circular(30),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.white.withOpacity(0.5),
//                   offset: const Offset(0, 16),
//                   blurRadius: 3,
//                   spreadRadius: -9),
//             ]),
//         child: SizedBox(
//           child: FutureBuilder(
//               future: fetchWpPostImageUrl(widget.imageApiUrl),
//               builder: (context, AsyncSnapshot snapshot) {
//                 if (snapshot.hasData) {
//                   imageUrl = snapshot.data["guid"]["rendered"];
//                   return Column(children: [
//                     Center(
//                       child: Text(
//                         widget.title,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           fontFamily: "Raleway",
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     Center(
//                       child: CachedNetworkImage(
//                         key: ObjectKey(imageUrl.hashCode),
//                         height: 100,
//                         imageUrl: imageUrl,
//                         placeholder: (context, url) =>
//                             const CircularProgressIndicator(),
//                         errorWidget: (context, url, error) =>
//                             const Icon(Icons.error),
//                       ),
//                     ),
//                     Expanded(
//                       child: Center(
//                         child: Text(
//                           widget.excerpt,
//                           style: const TextStyle(
//                             fontFamily: "Raleway",
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ]);
//                 }
//                 return const SizedBox(
//                     child: CircularProgressIndicator(), height: 100);
//               }),
//         ),
//       ),
//     );
//   }
// }
