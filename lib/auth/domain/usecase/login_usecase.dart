import 'package:fpdart/fpdart.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';
import 'package:get_it/get_it.dart';

class LoginUsecase {
  final IAuthRepository authRepository;

  LoginUsecase({required this.authRepository});

  TaskEither<BaseFailure, UserEntity> execute(
      {required String email, required String password}) {
    return authRepository.signIn(email: email, password: password);
  }

  static LoginUsecase get i => LoginUsecase(
        authRepository: GetIt.instance<IAuthRepository>(),
      );
}
