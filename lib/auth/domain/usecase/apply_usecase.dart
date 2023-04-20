import 'package:fpdart/fpdart.dart';
import 'package:sharewithme/auth/domain/model/appeal_entity.dart';
import 'package:sharewithme/auth/domain/repository/i_auth_repository.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';
import 'package:get_it/get_it.dart';

class ApplyUsecase {
  final IAuthRepository authRepository;

  ApplyUsecase({required this.authRepository});

  TaskEither<BaseFailure, Unit> execute({required AppealEntity appealEntity}) {
    return authRepository.apply(appealEntity: appealEntity);
  }

  static ApplyUsecase get i => ApplyUsecase(
        authRepository: GetIt.instance<IAuthRepository>(),
      );
}
