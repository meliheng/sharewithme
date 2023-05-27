part of 'auth_cubit.dart';

enum AuthStatus { initial, submitting, success, error }

class AuthState {
  final String email;
  final String password;
  final String nickname;
  final UserEntity? user;
  final AuthStatus status;
  AuthState({
    required this.email,
    required this.password,
    required this.status,
    required this.nickname,
    this.user,
  });
  factory AuthState.initial() {
    return AuthState(
      email: '',
      password: '',
      nickname: '',
      status: AuthStatus.initial,
    );
  }

  AuthState copyWith({
    String? email,
    String? password,
    String? nickname,
    AuthStatus? status,
    UserEntity? user,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      nickname: nickname ?? this.nickname,
      user: user ?? this.user,
    );
  }

  @override
  bool operator ==(covariant AuthState other) {
    return other.email == email &&
        other.password == password &&
        other.status == status &&
        other.nickname == nickname &&
        other.user == user;
  }

  @override
  int get hashCode =>
      email.hashCode ^
      password.hashCode ^
      status.hashCode ^
      nickname.hashCode ^
      user.hashCode;
}
