import 'package:fpdart/fpdart.dart';
import 'package:sharewithme/auth/domain/repository/i_auth_repository.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';
import 'package:get_it/get_it.dart';

class CreateUserUsecase {
  final IAuthRepository authRepository;

  CreateUserUsecase({required this.authRepository});

  TaskEither<BaseFailure, UserEntity> execute(
      {required String email, required String password}) {
    return authRepository.signUpWithEmailAndPassword(
        email: email, password: password);
  }

  static CreateUserUsecase get i => CreateUserUsecase(
        authRepository: GetIt.instance<IAuthRepository>(),
      );
}
