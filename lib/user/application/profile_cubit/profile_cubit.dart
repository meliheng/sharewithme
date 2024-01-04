import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/user/domain/repository/i_user_repository.dart';

class ProfileCubit extends Cubit<UserEntity> {
  final IUserRepository userRepository = IUserRepository.i;
  ProfileCubit({required UserEntity userEntity}) : super(userEntity);

  Future<void> updateAvatar(File file) async {
    await userRepository.updateAvatar(userEntity: state, file: file).run();
  }
}
