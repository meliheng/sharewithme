import 'package:fpdart/fpdart.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';
import 'package:get_it/get_it.dart';

class CheckApplyUsecase {
  final IAuthRepository authRepository;

  CheckApplyUsecase({required this.authRepository});

  TaskEither<BaseFailure, bool> execute({required String email}) {
    return authRepository.checkApply(email: email);
  }

  static CheckApplyUsecase get i => CheckApplyUsecase(
        authRepository: GetIt.instance<IAuthRepository>(),
      );
}
