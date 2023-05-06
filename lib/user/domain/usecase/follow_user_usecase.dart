import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:sharewithme/auth/auth_export.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';
import 'package:sharewithme/user/domain/repository/i_user_repository.dart';

class FollowUserUsecase {
  final IUserRepository userRepository;
  FollowUserUsecase({
    required this.userRepository,
  });

  TaskEither<BaseFailure, Unit> execute({required UserEntity userEntity}) {
    return userRepository.follow(userEntity: userEntity);
  }

  static FollowUserUsecase get i => FollowUserUsecase(
        userRepository: GetIt.instance<IUserRepository>(),
      );
}
