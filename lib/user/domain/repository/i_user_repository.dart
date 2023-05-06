import 'package:fpdart/fpdart.dart';
import 'package:sharewithme/auth/auth_export.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';

abstract class IUserRepository {
  TaskEither<BaseFailure, List<UserEntity>> getAll();
  TaskEither<BaseFailure, Unit> add({required UserEntity userEntity});
  TaskEither<BaseFailure, Unit> follow({required UserEntity userEntity});
}
