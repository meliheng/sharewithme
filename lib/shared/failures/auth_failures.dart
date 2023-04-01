import 'package:sharewithme/shared/failures/base_failure.dart';

class AuthFailures implements BaseFailure {
  @override
  final String message;

  AuthFailures(this.message);

  factory AuthFailures.def() {
    return AuthFailures("Something went wrong");
  }
}
