import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:sharewithme/auth/auth_export.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';

abstract class IUserRepository {
  TaskEither<BaseFailure, List<UserEntity>> getAll();
  TaskEither<BaseFailure, UserEntity> getById(String id);
  TaskEither<BaseFailure, Unit> add({required UserEntity userEntity});
  TaskEither<BaseFailure, Unit> follow({required UserEntity userEntity});
  TaskEither<BaseFailure, Unit> unFollow({required UserEntity userEntity});
  TaskEither<BaseFailure, Unit> updateAvatar(
      {required UserEntity userEntity, required File file});

  static IUserRepository get i => GetIt.instance<IUserRepository>();
}
