// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:sharewithme/auth/auth_export.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';
import 'package:sharewithme/user/domain/repository/i_user_repository.dart';

class GetAllUserUsecase {
  final IUserRepository userRepository;
  GetAllUserUsecase({
    required this.userRepository,
  });

  TaskEither<BaseFailure, List<UserEntity>> execute() {
    return userRepository.getAll();
  }

  static GetAllUserUsecase get i => GetAllUserUsecase(
        userRepository: GetIt.instance<IUserRepository>(),
      );
}
