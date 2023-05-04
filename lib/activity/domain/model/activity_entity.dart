// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharewithme/auth/auth_export.dart';

class ActivityEntity {
  final String content;
  final UserEntity user;

  ActivityEntity(this.content, this.user);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'userId': user.uid,
    };
  }

  factory ActivityEntity.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return ActivityEntity(
        data?['content'], UserEntity('email', data?['userId']));
  }

  factory ActivityEntity.fromMap(Map<String, dynamic> map) {
    return ActivityEntity(
      map['content'] as String,
      map['userId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityEntity.fromJson(String source) =>
      ActivityEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
