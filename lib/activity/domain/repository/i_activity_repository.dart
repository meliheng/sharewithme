import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:sharewithme/activity/domain/model/activity_entity.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';

abstract class IActivityRepository {
  TaskEither<BaseFailure, Unit> add({
    required ActivityEntity activityEntity,
    required File file,
  });
  TaskEither<BaseFailure, List<ActivityEntity>> getAll();
  TaskEither<BaseFailure, Unit> addComplaint(
      {required ActivityEntity activityEntity});
  TaskEither<BaseFailure, Unit> like({
    required String id,
    required String userId,
  });
  static IActivityRepository get i => GetIt.instance<IActivityRepository>();
}
