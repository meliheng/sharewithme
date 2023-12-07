import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/activity/presentation/widgets/activity_card.dart';
import 'package:sharewithme/export.dart';
import 'package:uuid/uuid.dart';

part 'activity_list_state.dart';

class ActivityListCubit extends Cubit<ActivityListState> {
  ActivityListCubit() : super(ActivityListState.initial());

  void contentChanged(String value) {
    emit(
      state.copyWith(
        content: value,
      ),
    );
  }

  void imageSelected(File file) {
    emit(
      state.copyWith(image: file),
    );
  }

  void getActivities(BuildContext context) async {
    emit(state.copyWith(status: ActivityListStatus.submitting));
    var response = await GetAllActivityUsecase.i.execute().run();
    response.fold(
      (l) {
        emit(state.copyWith(status: ActivityListStatus.error));
        if (state.status == ActivityListStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Birşeyler yanlış gitti 🧐'),
            ),
          );
        }
      },
      (r) {
        emit(
          state.copyWith(status: ActivityListStatus.success, activityList: r),
        );
      },
    );
  }

  void addActivity(BuildContext context) async {
    emit(state.copyWith(status: ActivityListStatus.submitting));
    final user = FirebaseAuth.instance.currentUser;
    var response = await AddActivityUsecase.i
        .execute(
          activityEntity: ActivityEntity(
            content: state.content,
            userId: user!.uid,
            username: user.email ?? '',
            date: state.date,
            id: const Uuid().v1(),
            likes: [],
            imagePath: '',
          ),
          file: state.image,
        )
        .run();
    Future.delayed(const Duration(seconds: 3));
    response.fold(
      (l) {
        emit(state.copyWith(status: ActivityListStatus.error));
        if (state.status == ActivityListStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Birşeyler yanlış gitti 🧐'),
            ),
          );
        }
      },
      (r) {
        emit(
          state.copyWith(status: ActivityListStatus.success),
        );
        Navigator.pop(context);
        getActivities(context);
        emit(state.copyWith());
      },
    );
  }

  StreamBuilder getAllActivity(
      {required UserEntity userEntity, bool onlyOwn = false}) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("activities").snapshots(),
      builder: (context, snapshot) {
        List<Widget> items = [];
        if (snapshot.hasData) {
          for (var element in snapshot.data!.docs) {
            var ac = ActivityEntity.fromFirestore(element);
            if (onlyOwn) {
              if (ac.userId == userEntity.uid) {
                items.add(
                  ActivityCard(
                    cubit: this,
                    activityEntity: ac,
                  ),
                );
              }
            } else {
              items.add(
                ActivityCard(
                  cubit: this,
                  activityEntity: ac,
                ),
              );
            }
          }
        }
        return Column(
          children: [
            ...items,
          ],
        );
      },
    );
  }

  void deleteActivity({required ActivityEntity activityEntity}) async {
    await FirebaseFirestore.instance
        .collection("activities")
        .where('id', isEqualTo: activityEntity.id)
        .get()
        .then(
      (value) {
        value.docs[0].reference.delete();
      },
    );
  }

  void addComplaint({
    required ActivityEntity activityEntity,
    required BuildContext context,
  }) async {
    emit(state.copyWith(status: ActivityListStatus.submitting));
    var response = await AddComplaintUsecase.i
        .execute(
          activityEntity: activityEntity,
        )
        .run();
    Future.delayed(const Duration(seconds: 3));
    response.fold(
      (l) {
        emit(state.copyWith(status: ActivityListStatus.error));
        if (state.status == ActivityListStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Birşeyler yanlış gitti 🧐'),
            ),
          );
        }
      },
      (r) {
        emit(
          state.copyWith(status: ActivityListStatus.success),
        );
      },
    );
  }

  Future<void> likeActivity(
      ActivityEntity activityEntity, UserEntity userEntity) async {
    try {
      var document = await FirebaseFirestore.instance
          .collection("activities")
          .where('id', isEqualTo: activityEntity.id)
          .get();

      FirebaseFirestore.instance
          .collection("activities")
          .doc(document.docs.first.id)
          .update(
        {
          'likes': FieldValue.arrayUnion([
            // ignore: use_build_context_synchronously
            userEntity.uid
          ]),
        },
      );
      emit(state.copyWith());
    } catch (e) {}
  }

  void onCommentAdded(CommentEntity commentEntity) {
    state.commentList.add(commentEntity);
    print("lenght");
    print(state.commentList.length);
    emit(
      state.copyWith(),
    );
  }

  Future<void> addComment(CommentEntity commentEntity) async {
    emit(state.copyWith(status: ActivityListStatus.submitting));
    await FirebaseFirestore.instance
        .collection('comments')
        .add(commentEntity.toMap());
    emit(state.copyWith(status: ActivityListStatus.success));
  }

  void getAllComments({required String activityId}) async {
    emit(state.copyWith(status: ActivityListStatus.submitting));
    await FirebaseFirestore.instance
        .collection('comments')
        .where('activityId', isEqualTo: activityId)
        .get()
        .then(
      (value) {
        for (var element in value.docs) {
          state.commentList.add(
            CommentEntity.fromFirestore(element),
          );
        }
      },
    );
    emit(state.copyWith(status: ActivityListStatus.success));
  }

  static ActivityListCubit instance() {
    return ActivityListCubit();
  }
}
