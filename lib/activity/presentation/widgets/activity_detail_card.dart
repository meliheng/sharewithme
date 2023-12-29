// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:sharewithme/export.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class ActivityDetailCard extends StatefulWidget {
//   final ActivityEntity activityEntity;
//   final UserEntity userEntity;
//   const ActivityDetailCard({
//     super.key,
//     required this.activityEntity,
//     required this.userEntity,
//   });

//   @override
//   State<ActivityDetailCard> createState() => _ActivityDetailCardState();
// }

// class _ActivityDetailCardState extends State<ActivityDetailCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             child: _buildNormalCard(),
//           ),
//         ),
//       ],
//     );
//   }

//   Card _buildNormalCard() {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.only(top: 8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: _firstRow(),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: _contentRow(),
//             ),
//             if (widget.activityEntity.imagePath.isNotEmpty) _imageRow(),
//           ],
//         ),
//       ),
//     );
//   }

//   Row _imageRow() {
//     return Row(
//       children: [
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: CachedNetworkImage(
//               fit: BoxFit.fitWidth,
//               height: 300,
//               progressIndicatorBuilder: (context, url, progress) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               },
//               imageUrl: widget.activityEntity.imagePath,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Row _contentRow() {
//     return Row(
//       children: [
//         Expanded(
//           child: Text(widget.activityEntity.content),
//         ),
//       ],
//     );
//   }

//   Row _firstRow() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           flex: 2,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             decoration: BoxDecoration(
//                 border: Border.all(color: Colors.white),
//                 borderRadius: BorderRadius.circular(5),
//                 color: Colors.white),
//             child: Text(widget.activityEntity.username),
//           ),
//         ),
//         Expanded(
//           child: Text(
//             DateFormat.yMMMMEEEEd().format(widget.activityEntity.date),
//             textAlign: TextAlign.end,
//           ),
//         ),
//       ],
//     );
//   }
// }
