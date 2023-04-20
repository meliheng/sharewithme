import 'package:fpdart/fpdart.dart';
import 'package:sharewithme/auth/auth_export.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';

abstract class IAuthRepository {
  TaskEither<BaseFailure, Unit> apply({required AppealEntity appealEntity});
  TaskEither<BaseFailure, UserEntity> signUpWithEmailAndPassword(
      {required String email, required String password});
}
