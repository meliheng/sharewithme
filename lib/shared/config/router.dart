import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';

class RouterManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.route:
        return pageGenerator(const LoginScreen());
      case SignUpPage.route:
        return pageGenerator(const SignUpPage());
      case ActivityScreen.route:
        return pageGenerator(
          ActivityScreen(
            authCubit: AuthCubit(),
          ),
        );

      default:
        return pageGenerator(const Text("error"));
    }
  }

  static pageGenerator(Widget widget) {
    return MaterialPageRoute(
      builder: (_) => widget,
    );
  }
}
