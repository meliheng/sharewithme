part of 'auth_cubit.dart';

enum AuthStatus { initial, submitting, success, error }

class AuthState {
  final String email;
  final String password;
  final String nickname;
  final File avatar;
  final AuthStatus status;
  AuthState({
    required this.email,
    required this.password,
    required this.nickname,
    required this.avatar,
    required this.status,
  });
  factory AuthState.initial() {
    return AuthState(
      email: '',
      password: '',
      nickname: '',
      avatar: File(IconC.kUserProfileIcon),
      status: AuthStatus.initial,
    );
  }

  AuthState copyWith({
    String? email,
    String? password,
    String? nickname,
    File? avatar,
    AuthStatus? status,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      nickname: nickname ?? this.nickname,
      avatar: avatar ?? this.avatar,
    );
  }

  @override
  bool operator ==(covariant AuthState other) {
    return other.email == email &&
        other.password == password &&
        other.status == status &&
        other.nickname == nickname &&
        other.avatar == avatar;
  }

  @override
  int get hashCode =>
      email.hashCode ^
      password.hashCode ^
      status.hashCode ^
      nickname.hashCode ^
      avatar.hashCode;
}
