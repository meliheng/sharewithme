part of 'apply_cubit.dart';

enum ApplyStatus { initial, submitting, success, error }

class ApplyState {
  final String fullname;
  final String school;
  final String department;
  final String email;
  final File file;
  final ApplyStatus status;
  ApplyState({
    required this.fullname,
    required this.school,
    required this.department,
    required this.email,
    required this.status,
    required this.file,
  });
  factory ApplyState.initial() {
    return ApplyState(
      department: "",
      fullname: "",
      school: "",
      email: "",
      file: File(""),
      status: ApplyStatus.initial,
    );
  }
  ApplyState copyWith({
    String? fullname,
    String? school,
    String? department,
    String? email,
    ApplyStatus? status,
    File? file,
  }) {
    return ApplyState(
      fullname: fullname ?? this.fullname,
      school: school ?? this.school,
      department: department ?? this.department,
      status: status ?? this.status,
      email: email ?? this.email,
      file: file ?? this.file,
    );
  }

  @override
  bool operator ==(covariant ApplyState other) {
    return other.fullname == fullname &&
        other.school == school &&
        other.department == department &&
        other.status == status &&
        other.email == email &&
        other.file == file;
  }

  @override
  int get hashCode {
    return fullname.hashCode ^
        school.hashCode ^
        department.hashCode ^
        email.hashCode ^
        file.hashCode ^
        status.hashCode;
  }
}
