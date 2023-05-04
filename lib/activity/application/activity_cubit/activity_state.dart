part of 'activity_cubit.dart';

enum ActivityStatus { initial, submitting, success, error }

class ActivityState {
  final String content;
  final ActivityStatus status;
  final List<ActivityEntity> activityList;
  ActivityState({
    required this.content,
    required this.status,
    required this.activityList,
  });
  factory ActivityState.initial() {
    return ActivityState(
        content: '', status: ActivityStatus.initial, activityList: []);
  }

  ActivityState copyWith({
    String? content,
    ActivityStatus? status,
    List<ActivityEntity>? activityList,
  }) {
    return ActivityState(
      content: content ?? this.content,
      status: status ?? this.status,
      activityList: activityList ?? this.activityList,
    );
  }

  @override
  bool operator ==(covariant ActivityState other) {
    return other.content == content &&
        other.status == status &&
        activityList == other.activityList;
  }

  @override
  int get hashCode =>
      content.hashCode ^ status.hashCode ^ activityList.hashCode;
}
