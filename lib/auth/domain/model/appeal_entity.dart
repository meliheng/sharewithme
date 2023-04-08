// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:sharewithme/export.dart';

class AppealEntity {
  final Name fullname;
  final Name school;
  final Name department;
  final String email;
  final File file;
  AppealEntity({
    required this.fullname,
    required this.school,
    required this.department,
    required this.email,
    required this.file,
  });

  AppealEntity copyWith({
    Name? fullname,
    Name? school,
    Name? department,
    String? email,
    File? file,
  }) {
    return AppealEntity(
      fullname: fullname ?? this.fullname,
      school: school ?? this.school,
      department: department ?? this.department,
      email: email ?? this.email,
      file: file ?? this.file,
    );
  }

  @override
  bool operator ==(covariant AppealEntity other) {
    return other.fullname == fullname &&
        other.school == school &&
        other.department == department &&
        other.email == email &&
        other.file == file;
  }

  @override
  int get hashCode =>
      fullname.hashCode ^
      school.hashCode ^
      department.hashCode ^
      email.hashCode ^
      file.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullname': fullname.value,
      'school': school.value,
      'department': department.value,
      'email': email,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'AppealEntity(fullname: $fullname, school: $school, department: $department)';
}
