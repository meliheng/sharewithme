part of 'activity_cubit.dart';

enum ActivityStatus { initial, submitting, success, error }

class ActivityState {
  final ActivityStatus status;
  final ActivityEntity activityEntity;
  final List<CommentEntity> commentList;
  ActivityState({
    required this.status,
    required this.activityEntity,
    required this.commentList,
  });
  factory ActivityState.initial() {
    return ActivityState(
      status: ActivityStatus.initial,
      commentList: [],
      activityEntity: ActivityEntity.def(),
    );
  }

  ActivityState copyWith({
    ActivityStatus? status,
    ActivityEntity? activityEntity,
    List<CommentEntity>? commentList,
  }) {
    return ActivityState(
      status: status ?? this.status,
      activityEntity: activityEntity ?? this.activityEntity.copyWith(),
      commentList: commentList ?? this.commentList,
    );
  }

  @override
  bool operator ==(covariant ActivityState other) {
    return other.status == status &&
        activityEntity == other.activityEntity &&
        commentList == other.commentList;
  }

  @override
  int get hashCode =>
      status.hashCode ^ commentList.hashCode ^ activityEntity.hashCode;
}
