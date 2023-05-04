import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';

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
            state.content,
            UserEntity('', user!.uid),
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
        Navigator.pushNamed(context, ActivityScreen.route);
      },
    );
  }
}
