// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'activity_list_cubit.dart';

enum ActivityListStatus { initial, submitting, success, error }

class ActivityListState {
  final String content;
  final File image;
  final DateTime date;
  final ActivityListStatus status;
  final List<ActivityEntity> activityList;
  final List<CommentEntity> commentList;
  ActivityListState({
    required this.content,
    required this.image,
    required this.date,
    required this.status,
    required this.activityList,
    required this.commentList,
  });
  factory ActivityListState.initial() {
    return ActivityListState(
      content: '',
      status: ActivityListStatus.initial,
      activityList: [],
      date: DateTime.now(),
      image: File(''),
      commentList: [],
    );
  }

  ActivityListState copyWith({
    String? content,
    ActivityListStatus? status,
    List<ActivityEntity>? activityList,
    DateTime? date,
    File? image,
    List<CommentEntity>? commentList,
  }) {
    return ActivityListState(
      content: content ?? this.content,
      status: status ?? this.status,
      activityList: activityList ?? this.activityList,
      date: date ?? this.date,
      image: image ?? this.image,
      commentList: commentList ?? this.commentList,
    );
  }

  @override
  bool operator ==(covariant ActivityListState other) {
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
