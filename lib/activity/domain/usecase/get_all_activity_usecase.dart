import 'package:fpdart/fpdart.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';
import 'package:get_it/get_it.dart';

class GetAllActivityUsecase {
  final IActivityRepository activityRepository;

  GetAllActivityUsecase({required this.activityRepository});

  TaskEither<BaseFailure, List<ActivityEntity>> execute() {
    return activityRepository.getAll();
  }

  static GetAllActivityUsecase get i => GetAllActivityUsecase(
        activityRepository: GetIt.instance<IActivityRepository>(),
      );
}
