import 'package:fpdart/fpdart.dart';
import 'package:sharewithme/auth/auth_export.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';

abstract class IAuthRepository {
  TaskEither<BaseFailure, Unit> apply({required AppealEntity appealEntity});
  TaskEither<BaseFailure, UserEntity> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String username});
  TaskEither<BaseFailure, UserEntity> signUpWithGoogle(
      {required String email,
      required String password,
      required String username});
  TaskEither<BaseFailure, UserEntity> signIn(
      {required String email, required String password});
  TaskEither<BaseFailure, Unit> logout();
  TaskEither<BaseFailure, bool> checkApply({required String email});
}
