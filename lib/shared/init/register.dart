import 'package:get_it/get_it.dart';
import 'package:sharewithme/auth/data/repository/auth_repository.dart';
import 'package:sharewithme/auth/domain/repository/i_auth_repository.dart';

class Register {
  static void setUp() {
    GetIt.I.registerSingleton<IAuthRepository>(AuthRepository());
  }
}
