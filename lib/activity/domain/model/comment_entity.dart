// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CommentEntity {
  final String activityId;
  final String userId;
  final String comment;
  CommentEntity({
    required this.activityId,
    required this.userId,
    required this.comment,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'activityId': activityId,
      'userId': userId,
      'comment': comment,
    };
  }

  factory CommentEntity.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return CommentEntity(
      activityId: data?['activityId'],
      userId: data?['userId'],
      comment: data?['comment'],
    );
  }

  String toJson() => json.encode(toMap());
}
