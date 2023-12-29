// import 'package:expansion_tile_card/expansion_tile_card.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sharewithme/activity/application/activity_cubit/activity_cubit.dart';
// import 'package:sharewithme/activity/domain/_domain_exporter.dart';
// import 'package:sharewithme/activity/presentation/widgets/activity_detail_card.dart';
// import 'package:sharewithme/auth/domain/_domain_exporter.dart';
// import 'package:sharewithme/shared/_shared_exporter.dart';

// class ActivityDetailScreen extends StatefulWidget {
//   final ActivityEntity activityEntity;
//   final UserEntity userEntity;

//   const ActivityDetailScreen({
//     super.key,
//     required this.activityEntity,
//     required this.userEntity,
//   });

//   @override
//   State<ActivityDetailScreen> createState() => _ActivityDetailScreenState();
// }

// class _ActivityDetailScreenState extends State<ActivityDetailScreen> {
//   late ActivityCubit activityCubit;
//   @override
//   void initState() {
//     super.initState();
//     activityCubit =
//         ActivityCubit.instance(activityEntity: widget.activityEntity);
//     activityCubit.getAllComments();
//   }

//   final TextEditingController commentController =
//       TextEditingController(text: "");
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocConsumer<ActivityCubit, ActivityState>(
//         bloc: activityCubit,
//         listener: (context, state) {},
//         builder: (context, state) {
//           return ListView(
//             children: [
//               ActivityDetailCard(
//                 activityEntity: widget.activityEntity,
//                 userEntity: widget.userEntity,
//               ),
//               if (state.status == ActivityStatus.submitting)
//                 const CircularProgressIndicator()
//               else
//                 _commentCard(context, state),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   ExpansionTileCard _commentCard(BuildContext context, ActivityState state) {
//     return ExpansionTileCard(
//       title: const Text("Yorumlar"),
//       children: [
//         const Divider(
//           thickness: 1.0,
//           height: 1.0,
//         ),
//         if (activityCubit.state.commentList.isNotEmpty)
//           for (var i in activityCubit.state.commentList) ...[
//             Container(
//               decoration: const BoxDecoration(shape: BoxShape.rectangle),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         i.comment,
//                         style: const TextStyle(fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         TextFieldWithIcon(
//           hintText: "Haydi yorumunu yaz",
//           icon: Icons.comment_bank,
//           onChanged: (p0) {},
//           controller: commentController,
//         ),
//         CustomButton(
//           title: "Paylaş",
//           color: ColorConstants.primaryOrange,
//           onPressed: () async {
//             CommentEntity comment = CommentEntity(
//               activityId: widget.activityEntity.id,
//               userId: FirebaseAuth.instance.currentUser!.uid,
//               comment: commentController.text,
//             );
//             activityCubit.onCommentAdded(comment);
//             commentController.clear();
//             await activityCubit.addComment(comment);
//           },
//         ),
//       ],
//     );
//   }
// }
