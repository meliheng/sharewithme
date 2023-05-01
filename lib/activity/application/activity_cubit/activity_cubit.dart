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

  void addActivity(BuildContext context) async {
    emit(state.copyWith(status: ActivityStatus.submitting));
    final user = FirebaseAuth.instance.currentUser;
    var response = await AddActivityUsecase.i
        .execute(activityEntity: ActivityEntity(state.content, user!.uid))
        .run();
    Future.delayed(const Duration(seconds: 3));
    response.fold(
      (l) {
        print(l.message);
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
