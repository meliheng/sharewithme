// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ActivityEntity {
  final String content;
  final String userId;

  ActivityEntity(this.content, this.userId);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
    };
  }

  factory ActivityEntity.fromMap(Map<String, dynamic> map) {
    return ActivityEntity(
      map['content'] as String,
      map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityEntity.fromJson(String source) =>
      ActivityEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
