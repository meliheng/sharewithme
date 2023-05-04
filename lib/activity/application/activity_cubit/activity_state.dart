part of 'activity_cubit.dart';

enum ActivityStatus { initial, submitting, success, error }

class ActivityState {
  final String content;
  final DateTime date;
  final ActivityStatus status;
  final List<ActivityEntity> activityList;
  ActivityState({
    required this.content,
    required this.status,
    required this.activityList,
    required this.date,
  });
  factory ActivityState.initial() {
    return ActivityState(
      content: '',
      status: ActivityStatus.initial,
      activityList: [],
      date: DateTime.now(),
    );
  }

  ActivityState copyWith({
    String? content,
    ActivityStatus? status,
    List<ActivityEntity>? activityList,
    DateTime? date,
  }) {
    return ActivityState(
      content: content ?? this.content,
      status: status ?? this.status,
      activityList: activityList ?? this.activityList,
      date: date ?? this.date,
    );
  }

  @override
  bool operator ==(covariant ActivityState other) {
    return other.content == content &&
        other.status == status &&
        activityList == other.activityList &&
        date == other.date;
  }

  @override
  int get hashCode =>
      content.hashCode ^
      status.hashCode ^
      activityList.hashCode ^
      date.hashCode;
}
