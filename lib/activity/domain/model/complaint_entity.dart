// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintEntity {
  final String id;
  final int count;
  final bool isArchieved;
  ComplaintEntity({
    required this.id,
    required this.count,
    required this.isArchieved,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'count': count,
      'isArchieved': isArchieved,
    };
  }

  factory ComplaintEntity.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return ComplaintEntity(
      id: data?['id'],
      count: data?['count'],
      isArchieved: data?['isArchieved'],
    );
  }

  String toJson() => json.encode(toMap());
}
