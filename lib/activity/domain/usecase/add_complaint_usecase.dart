import 'package:fpdart/fpdart.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';
import 'package:get_it/get_it.dart';

class AddComplaintUsecase {
  final IActivityRepository activityRepository;

  AddComplaintUsecase({required this.activityRepository});

  TaskEither<BaseFailure, Unit> execute(
      {required ActivityEntity activityEntity}) {
    return activityRepository.addComplaint(activityEntity: activityEntity);
  }

  static AddComplaintUsecase get i => AddComplaintUsecase(
        activityRepository: GetIt.instance<IActivityRepository>(),
      );
}
