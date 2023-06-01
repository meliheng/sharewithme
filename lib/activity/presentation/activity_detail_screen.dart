import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sharewithme/activity/application/_application_exporter.dart';
import 'package:sharewithme/activity/domain/_domain_exporter.dart';
import 'package:sharewithme/activity/presentation/widgets/activity_card.dart';
import 'package:sharewithme/auth/domain/_domain_exporter.dart';
import 'package:sharewithme/shared/_shared_exporter.dart';

class ActivityDetailScreen extends StatefulWidget {
  final ActivityCubit activityCubit;
  final ActivityEntity activityEntity;
  final UserEntity userEntity;

  const ActivityDetailScreen({
    super.key,
    required this.activityCubit,
    required this.activityEntity,
    required this.userEntity,
  });

  @override
  State<ActivityDetailScreen> createState() => _ActivityDetailScreenState();
}

class _ActivityDetailScreenState extends State<ActivityDetailScreen> {
  @override
  void initState() {
    super.initState();
    widget.activityCubit.getAllComments(activityId: widget.activityEntity.id);
    print(widget.activityCubit.state.commentList!.length);
  }

  final TextEditingController commentController =
      TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ActivityCard(
            cubit: widget.activityCubit,
            activityEntity: widget.activityEntity,
            userEntity: widget.userEntity,
            isProfileScreen: false,
          ),
          _aboutMeCard(context),
        ],
      ),
    );
  }

  ExpansionTileCard _aboutMeCard(BuildContext context) {
    return ExpansionTileCard(
      title: const Text("Yorumlar"),
      children: [
        const Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        if (widget.activityCubit.state.commentList!.isNotEmpty)
          for (var i in widget.activityCubit.state.commentList!) ...[
            widget.activityCubit.state.status == ActivityStatus.submitting
                ? const CircularProgressIndicator()
                : Container(
                    decoration: const BoxDecoration(shape: BoxShape.rectangle),
                    child: Text(
                      i.comment,
                    ),
                  ),
          ],
        TextFieldWithIcon(
          hintText: "Haydi yorumunu yaz",
          icon: Icons.comment_bank,
          onChanged: (p0) {},
          controller: commentController,
        ),
        CustomButton(
          title: "Paylaş",
          color: ColorConstants.primaryOrange,
          onPressed: () {
            CommentEntity comment = CommentEntity(
              activityId: widget.activityEntity.id,
              userId: FirebaseAuth.instance.currentUser!.uid,
              comment: commentController.text,
            );
            widget.activityCubit.addComment(comment);
          },
        ),
      ],
    );
  }
}
