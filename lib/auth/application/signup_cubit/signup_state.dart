import 'dart:io';
import 'package:sharewithme/shared/vo/status_enum.dart';

class SignUpState {
  final String email;
  final String password;
  final String nickname;
  final File avatar;
  final Status status;

  SignUpState({
    required this.email,
    required this.password,
    required this.nickname,
    required this.avatar,
    required this.status,
  });
  factory SignUpState.initial() {
    return SignUpState(
      email: '',
      password: '',
      nickname: '',
      avatar: File(''),
      status: Status.initial,
    );
  }

  SignUpState copyWith({
    String? email,
    String? password,
    String? nickname,
    File? avatar,
    Status? status,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      nickname: nickname ?? this.nickname,
      avatar: avatar ?? this.avatar,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(covariant SignUpState other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.password == password &&
        other.nickname == nickname &&
        other.avatar == avatar &&
        other.status == status;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        nickname.hashCode ^
        avatar.hashCode ^
        status.hashCode;
  }
}
