import 'package:sharewithme/export.dart';

enum ActivityStatus { initial, submitting, success, error }

class ActivityState {
  final ActivityStatus status;
  final ActivityEntity activityEntity;
  ActivityState({
    required this.status,
    required this.activityEntity,
  });
  factory ActivityState.initial() {
    return ActivityState(
      status: ActivityStatus.initial,
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
    );
  }

  @override
  bool operator ==(covariant ActivityState other) {
    return other.status == status && activityEntity == other.activityEntity;
  }

  @override
  int get hashCode => status.hashCode ^ activityEntity.hashCode;
}
