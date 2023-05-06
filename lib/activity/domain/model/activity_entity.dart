// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityEntity {
  final String content;
  final String userId;
  final String username;
  final DateTime date;
  ActivityEntity({
    required this.content,
    required this.userId,
    required this.username,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'userId': userId,
      'username': username,
      'date': date,
    };
  }

  factory ActivityEntity.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return ActivityEntity(
      content: data?['content'],
      userId: data?['userId'],
      username: data?['username'],
      date: (data?['date'] as Timestamp).toDate(),
    );
  }

  // factory ActivityEntity.fromMap(Map<String, dynamic> map) {
  //   return ActivityEntity(
  //     map['content'] as String,
  //     map['userId'],
  //   );
  // }

  String toJson() => json.encode(toMap());

  // factory ActivityEntity.fromJson(String source) =>
  //     ActivityEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
