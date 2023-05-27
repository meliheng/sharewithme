import 'package:fpdart/fpdart.dart';
import 'package:sharewithme/auth/domain/repository/i_auth_repository.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';
import 'package:get_it/get_it.dart';

class LogoutUsecase {
  final IAuthRepository authRepository;

  LogoutUsecase({required this.authRepository});

  TaskEither<BaseFailure, Unit> execute() {
    return authRepository.logout();
  }

  static LogoutUsecase get i => LogoutUsecase(
        authRepository: GetIt.instance<IAuthRepository>(),
      );
}
