import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/user/user_export.dart';

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
      case UserListScreen.route:
        return pageGenerator(
          UserListScreen(
            pageCubit: PageCubit(),
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
