import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityEntity {
  final String id;
  final String userId;
  final DateTime date;
  final List<String> likes;
  final String imagePath;
  ActivityEntity({
    required this.userId,
    required this.date,
    required this.id,
    required this.likes,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'date': date,
      'likes': likes,
      'imagePath': imagePath,
    };
  }

  factory ActivityEntity.def() {
    return ActivityEntity(
      userId: "",
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
      userId: data?['userId'],
      date: (data?['date'] as Timestamp).toDate(),
      id: snapshot.id,
      likes: List.from(data?['likes']),
      imagePath: data?['imagePath'] ?? '',
    );
  }
  String get totalLikeString {
    return likes.length.toString();
  }

  String toJson() => json.encode(toMap());

  ActivityEntity copyWith({
    String? id,
    String? userId,
    DateTime? date,
    List<String>? likes,
    String? imagePath,
  }) {
    return ActivityEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      likes: likes ?? this.likes,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
