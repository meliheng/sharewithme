import 'package:fpdart/fpdart.dart';
import 'package:sharewithme/activity/domain/model/activity_entity.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';
import 'package:get_it/get_it.dart';

class AddActivityUsecase {
  final IActivityRepository activityRepository;

  AddActivityUsecase({required this.activityRepository});

  TaskEither<BaseFailure, Unit> execute(
      {required ActivityEntity activityEntity}) {
    return activityRepository.add(activityEntity: activityEntity);
  }

  static AddActivityUsecase get i => AddActivityUsecase(
        activityRepository: GetIt.instance<IActivityRepository>(),
      );
}
