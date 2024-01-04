import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/user/domain/repository/i_user_repository.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit({required ActivityEntity activityEntity})
      : super(ActivityState.initial()) {
    emit(
      state.copyWith(activityEntity: activityEntity),
    );
  }

  final IActivityRepository activityRepository = IActivityRepository.i;
  final IUserRepository userRepository = IUserRepository.i;
  Future<void> likeActivity() async {
    await activityRepository
        .like(
          id: state.activityEntity.id,
          userId: FirebaseAuth.instance.currentUser!.uid,
        )
        .run();
  }
}
