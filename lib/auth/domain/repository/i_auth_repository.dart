import 'package:fpdart/fpdart.dart';
import 'package:sharewithme/auth/domain/model/appeal_entity.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';

abstract class IAuthRepository {
  TaskEither<BaseFailure, Unit> apply({required AppealEntity appealEntity});
}
