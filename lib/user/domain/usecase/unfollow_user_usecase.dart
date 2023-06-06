import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:sharewithme/auth/auth_export.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';
import 'package:sharewithme/user/domain/repository/i_user_repository.dart';

class UnFollowUserUsecase {
  final IUserRepository userRepository;
  UnFollowUserUsecase({
    required this.userRepository,
  });

  TaskEither<BaseFailure, Unit> execute({required UserEntity userEntity}) {
    return userRepository.unFollow(userEntity: userEntity);
  }

  static UnFollowUserUsecase get i => UnFollowUserUsecase(
        userRepository: GetIt.instance<IUserRepository>(),
      );
}
