// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityEntity {
  final String id;
  final String content;
  final String userId;
  final String username;
  final DateTime date;
  final List likes;
  final String imagePath;
  ActivityEntity({
    required this.content,
    required this.userId,
    required this.username,
    required this.date,
    required this.id,
    required this.likes,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'userId': userId,
      'username': username,
      'date': date,
      'id': id,
      'likes': likes,
      'imagePath': imagePath,
    };
  }

  factory ActivityEntity.def() {
    return ActivityEntity(
      content: "",
      userId: "",
      username: "",
      date: DateTime.now(),
      id: "",
      likes: [],
      imagePath: "",
    );
  }

  factory ActivityEntity.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return ActivityEntity(
      content: data?['content'],
      userId: data?['userId'],
      username: data?['username'],
      date: (data?['date'] as Timestamp).toDate(),
      id: data?['id'],
      likes: data?['likes'] ?? [],
      imagePath: data?['imagePath'] ?? '',
    );
  }

  // factory ActivityEntity.fromMap(Map<String, dynamic> map) {
  //   return ActivityEntity(
  //     map['content'] as String,
  //     map['userId'],
  //   );
  // }
  String get totalLikeString {
    return likes.length.toString();
  }

  String toJson() => json.encode(toMap());

  // factory ActivityEntity.fromJson(String source) =>
  //     ActivityEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  ActivityEntity copyWith({
    String? id,
    String? content,
    String? userId,
    String? username,
    DateTime? date,
    List? likes,
    String? imagePath,
  }) {
    return ActivityEntity(
      id: id ?? this.id,
      content: content ?? this.content,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      date: date ?? this.date,
      likes: likes ?? this.likes,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
