
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/activity/presentation/widgets/activity_card.dart';
import 'package:sharewithme/export.dart';
import 'package:uuid/uuid.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit() : super(ActivityState.initial());

  void contentChanged(String value) {
    emit(
      state.copyWith(
        content: value,
      ),
    );
  }

  void getActivities(BuildContext context) async {
    emit(state.copyWith(status: ActivityStatus.submitting));
    var response = await GetAllActivityUsecase.i.execute().run();
    response.fold(
      (l) {
        emit(state.copyWith(status: ActivityStatus.error));
        if (state.status == ActivityStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Birşeyler yanlış gitti 🧐'),
            ),
          );
        }
      },
      (r) {
        emit(
          state.copyWith(status: ActivityStatus.success, activityList: r),
        );
      },
    );
  }

  void addActivity(BuildContext context) async {
    emit(state.copyWith(status: ActivityStatus.submitting));
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
          ),
        )
        .run();
    Future.delayed(const Duration(seconds: 3));
    response.fold(
      (l) {
        emit(state.copyWith(status: ActivityStatus.error));
        if (state.status == ActivityStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Birşeyler yanlış gitti 🧐'),
            ),
          );
        }
      },
      (r) {
        emit(
          state.copyWith(status: ActivityStatus.success),
        );
        Navigator.pop(context);
        getActivities(context);
        emit(state.copyWith());
      },
    );
  }

  StreamBuilder getAllActivity({required UserEntity userEntity}) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("activities").snapshots(),
      builder: (context, snapshot) {
        List<Widget> items = [];
        if (snapshot.hasData) {
          for (var element in snapshot.data!.docs) {
            var ac = ActivityEntity.fromFirestore(element);
            items.add(
              ActivityCard(
                cubit: this,
                activityEntity: ac,
                userEntity: userEntity,
              ),
            );
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

  Future<void> likeActivity(ActivityEntity activityEntity,UserEntity userEntity) async {
    try {
      var document = await FirebaseFirestore.instance
          .collection("activities")
          .where('id', isEqualTo: activityEntity.id)
          .get();
      // var id= context.read<AuthCubit>().state.user!.uid;
      // print(id);
      print("""""object""""");
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

  static ActivityCubit instance() {
    return ActivityCubit();
  }
}
