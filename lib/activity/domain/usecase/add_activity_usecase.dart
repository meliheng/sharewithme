import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';
import 'package:get_it/get_it.dart';

class AddActivityUsecase {
  final IActivityRepository activityRepository;

  AddActivityUsecase({required this.activityRepository});

  TaskEither<BaseFailure, Unit> execute({
    required ActivityEntity activityEntity,
    required File file,
  }) {
    return activityRepository.add(
      activityEntity: activityEntity,
      file: file,
    );
  }

  static AddActivityUsecase get i => AddActivityUsecase(
        activityRepository: GetIt.instance<IActivityRepository>(),
      );
}
