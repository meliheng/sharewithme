import 'package:fpdart/fpdart.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';
import 'package:get_it/get_it.dart';

class SignUpWithGoogle {
  final IAuthRepository authRepository;

  SignUpWithGoogle({required this.authRepository});

  TaskEither<BaseFailure, UserEntity> execute(
      {required String email, required String password}) {
    return authRepository.signUpWithGoogle(
      email: email,
      password: password,
      username: "ddd",
    );
  }

  static SignUpWithGoogle get i => SignUpWithGoogle(
        authRepository: GetIt.instance<IAuthRepository>(),
      );
}
