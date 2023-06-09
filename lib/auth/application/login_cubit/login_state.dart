part of 'login_cubit.dart';

enum LoginStatus { initial, submitting, success, error }

class LoginState {
  final String email;
  final String password;
  final LoginStatus status;
  LoginState({
    required this.email,
    required this.password,
    required this.status,
  });
  factory LoginState.initial() {
    return LoginState(email: '', password: '', status: LoginStatus.initial);
  }

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(covariant LoginState other) {
    return other.email == email &&
        other.password == password &&
        other.status == status;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ status.hashCode;
}
