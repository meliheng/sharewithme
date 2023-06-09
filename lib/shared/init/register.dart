import 'package:get_it/get_it.dart';
import 'package:sharewithme/activity/data/repository/activity_repository.dart';
import 'package:sharewithme/activity/domain/repository/i_activity_repository.dart';
import 'package:sharewithme/auth/data/repository/auth_repository.dart';
import 'package:sharewithme/auth/domain/repository/i_auth_repository.dart';
import 'package:sharewithme/user/data/repository/user_repository.dart';
import 'package:sharewithme/user/domain/repository/i_user_repository.dart';

class Register {
  static void setUp() {
    GetIt.I.registerSingleton<IAuthRepository>(AuthRepository());
    GetIt.I
        .registerLazySingleton<IActivityRepository>(() => ActivityRepository());
    GetIt.I.registerLazySingleton<IUserRepository>(() => UserRepository());
  }
}
