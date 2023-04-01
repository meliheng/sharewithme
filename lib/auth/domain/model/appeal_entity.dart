// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:sharewithme/export.dart';

class AppealEntity {
  final Name fullname;
  final Name school;
  final Name department;
  AppealEntity({
    required this.fullname,
    required this.school,
    required this.department,
  });

  AppealEntity copyWith({
    Name? fullname,
    Name? school,
    Name? department,
  }) {
    return AppealEntity(
      fullname: fullname ?? this.fullname,
      school: school ?? this.school,
      department: department ?? this.department,
    );
  }

  @override
  bool operator ==(covariant AppealEntity other) {
    if (identical(this, other)) return true;

    return other.fullname == fullname &&
        other.school == school &&
        other.department == department;
  }

  @override
  int get hashCode => fullname.hashCode ^ school.hashCode ^ department.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullname': fullname.value,
      'school': school.value,
      'department': department.value,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'AppealEntity(fullname: $fullname, school: $school, department: $department)';
}
