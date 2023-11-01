import 'package:flutter/material.dart';
import 'package:sharewithme/auth/presentation/screen/appeal_screen.dart';
import 'package:sharewithme/auth/presentation/screen/login_screen.dart';
import 'package:sharewithme/auth/presentation/screen/signup_screen.dart';

class NavigationCubit {
  void onLoginPressed(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.route);
  }

  void onSignUpPressed(BuildContext context) {
    Navigator.pushNamed(context, SignUpPage.route);
  }

  void onAppealPressed(BuildContext context) {
    Navigator.pushNamed(context, AppealPage.route);
  }
}
