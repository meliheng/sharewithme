// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:sharewithme/auth/auth_export.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';
import 'package:sharewithme/user/domain/repository/i_user_repository.dart';

class AddUserUsecase {
  final IUserRepository userRepository;
  AddUserUsecase({
    required this.userRepository,
  });

  TaskEither<BaseFailure, Unit> execute({required UserEntity userEntity}) {
    return userRepository.add(userEntity: userEntity);
  }

  static AddUserUsecase get i => AddUserUsecase(
        userRepository: GetIt.instance<IUserRepository>(),
      );
}
