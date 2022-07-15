// import 'dart:convert';
// import 'package:bigboxo_application/utils/helpers/string_helper.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import '../model/show.dart';
// import '../services/show_client.dart';
// import 'items_skeleton.dart';

// class ShowList extends StatelessWidget {
//   const ShowList({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size deviceSize = MediaQuery.of(context).size;
//     ShowClient showClient = ShowClient.getShowClientInstance();
//     return Container(
//         height: deviceSize.height * 0.34,
//         child: FutureBuilder(
//             future: showClient
//                 .getRecommededShows(), // Firebase read operation , which gives future
//             builder:
//                 (BuildContext ctx, AsyncSnapshot<Response<dynamic>> snapshot) {
//               ConnectionState state = snapshot.connectionState;

//               // loading
//               if (state == ConnectionState.waiting) {
//                 return const Center(child: ItemSkeleton());
//               }
//               // error
//               else if (snapshot.hasError) {
//                 return Center(
//                   child: Image.asset(
//                     'assets/images/crash.gif',
//                     width: deviceSize.width
//                   ),
//                 );
//               }
//               // loaded
//               else {
//                 return _printMovies(snapshot);
//               }
//             }
//           )
//         );
//   }

//   _printMovies(AsyncSnapshot snapshot) {
//     Map<String, dynamic> json = jsonDecode(snapshot.data.toString());
//     List<dynamic> docList = json['results'];
//     List<Show> showsList = docList.map((doc) => Show.fromJSON(doc)).toList();
//     showsList.sort((showA,showB) => showB.rating.compareTo(showA.rating));

//     return ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: 10,
//       itemBuilder: (BuildContext ctx, int i) {
//         return Padding(
//           padding: const EdgeInsets.only(left: 20.0, right: 10, top: 10),
//           child: GestureDetector(
//             onTap: () {
//               print(showsList[i].title);
//             },
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Stack(children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.network(
//                       showsList[i].imageurl,
//                       height: 170,
//                       width: 120,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Positioned(
//                       bottom: 5,
//                       left: 5,
//                       child: Container(
//                           color: Colors.grey.withOpacity(0.8),
//                           child: Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: Row(children: [
//                                 const Icon(
//                                   Icons.favorite,
//                                   color: Colors.red,
//                                   size: 14,
//                                 ),
//                                 const SizedBox(
//                                   width: 5,
//                                 ),
//                                 Text(
//                                   "${showsList[i].rating}",
//                                   style: const TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ]))))
//                 ]),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 Container(
//                   width: 115,
//                   child: Text(
//                     showsList[i].title,
//                     style: const TextStyle(
//                         fontSize: 12,
//                         color: Colors.black,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.language,
//                       color: Colors.black,
//                       size: 14,
//                     ),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Text(
//                       'Hindi',
//                       style: const TextStyle(
//                           fontSize: 10,
//                           color: Colors.green,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   height: 20,
//                   width: 120,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.grey.shade200,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Center(
//                       child: Text(
//                         StringHelper.convertToCategoryFormat(
//                             showsList[i].genres),
//                         style: const TextStyle(
//                             fontSize: 10,
//                             color: Colors.orange,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
