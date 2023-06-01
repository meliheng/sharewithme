// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'activity_cubit.dart';

enum ActivityStatus { initial, submitting, success, error }

class ActivityState {
  final String content;
  final File image;
  final DateTime date;
  final ActivityStatus status;
  final List<ActivityEntity> activityList;
  final List<CommentEntity>? commentList;
  ActivityState({
    required this.content,
    required this.image,
    required this.date,
    required this.status,
    required this.activityList,
    this.commentList = const [],
  });
  factory ActivityState.initial() {
    return ActivityState(
      content: '',
      status: ActivityStatus.initial,
      activityList: [],
      date: DateTime.now(),
      image: File(''),
      commentList: [],
    );
  }

  ActivityState copyWith({
    String? content,
    ActivityStatus? status,
    List<ActivityEntity>? activityList,
    DateTime? date,
    File? image,
    List<CommentEntity>? commentList,
  }) {
    return ActivityState(
      content: content ?? this.content,
      status: status ?? this.status,
      activityList: activityList ?? this.activityList,
      date: date ?? this.date,
      image: image ?? this.image,
      commentList: commentList ?? this.commentList,
    );
  }

  @override
  bool operator ==(covariant ActivityState other) {
    return other.content == content &&
        other.status == status &&
        activityList == other.activityList &&
        date == other.date &&
        image == other.image &&
        commentList == other.commentList;
  }

  @override
  int get hashCode =>
      content.hashCode ^
      status.hashCode ^
      activityList.hashCode ^
      date.hashCode ^
      image.hashCode ^
      commentList.hashCode;
}
