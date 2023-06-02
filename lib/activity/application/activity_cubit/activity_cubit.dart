import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/export.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit({required ActivityEntity activityEntity})
      : super(ActivityState.initial()) {
    emit(state.copyWith(activityEntity: activityEntity));
  }

  void onCommentAdded(CommentEntity commentEntity) {
    state.commentList.add(commentEntity);
    emit(
      state.copyWith(),
    );
  }

  Future<void> addComment(CommentEntity commentEntity) async {
    emit(state.copyWith(status: ActivityStatus.submitting));
    await FirebaseFirestore.instance
        .collection('comments')
        .add(commentEntity.toMap());
    emit(state.copyWith(status: ActivityStatus.success));
  }

  void getAllComments() async {
    emit(state.copyWith(status: ActivityStatus.submitting));
    await FirebaseFirestore.instance
        .collection('comments')
        .where('activityId', isEqualTo: state.activityEntity.id)
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
    emit(state.copyWith(status: ActivityStatus.success));
  }

  static ActivityCubit instance({required ActivityEntity activityEntity}) {
    return ActivityCubit(activityEntity: activityEntity);
  }
}
