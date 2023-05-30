import 'dart:io';

import 'package:fpdart/fpdart.dart';
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
}
