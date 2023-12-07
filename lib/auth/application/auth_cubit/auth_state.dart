part of 'auth_cubit.dart';

enum AuthStatus { initial, submitting, success, error }

class AuthState {
  final String email;
  final String password;
  final String nickname;
  final String imagePath;
  final AuthStatus status;
  AuthState({
    required this.email,
    required this.password,
    required this.nickname,
    required this.imagePath,
    required this.status,
  });
  factory AuthState.initial() {
    return AuthState(
      email: '',
      password: '',
      nickname: '',
      imagePath: ImageC.userProfileIcon,
      status: AuthStatus.initial,
    );
  }

  AuthState copyWith({
    String? email,
    String? password,
    String? nickname,
    String? imagePath,
    AuthStatus? status,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      nickname: nickname ?? this.nickname,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  bool operator ==(covariant AuthState other) {
    return other.email == email &&
        other.password == password &&
        other.status == status &&
        other.nickname == nickname &&
        other.imagePath == imagePath;
  }

  @override
  int get hashCode =>
      email.hashCode ^
      password.hashCode ^
      status.hashCode ^
      nickname.hashCode ^
      imagePath.hashCode;
}
