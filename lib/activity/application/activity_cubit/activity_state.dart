part of 'activity_cubit.dart';

enum ActivityStatus { initial, submitting, success, error }

class ActivityState {
  final String content;
  final ActivityStatus status;
  ActivityState({
    required this.content,
    required this.status,
  });
  factory ActivityState.initial() {
    return ActivityState(content: '', status: ActivityStatus.initial);
  }

  ActivityState copyWith({
    String? content,
    ActivityStatus? status,
  }) {
    return ActivityState(
      content: content ?? this.content,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(covariant ActivityState other) {
    return other.content == content && other.status == status;
  }

  @override
  int get hashCode => content.hashCode ^ status.hashCode;
}
