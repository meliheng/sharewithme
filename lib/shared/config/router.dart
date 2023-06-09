import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/home/page_cubit.dart';
import 'package:sharewithme/user/presentation/user_list_screen.dart';

class RouterManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.route:
        return pageGenerator(const LoginScreen());
      case WelcomeScreen.route:
        return pageGenerator(const WelcomeScreen());
      case ActivityScreen.route:
        return pageGenerator(
          ActivityScreen(
            authCubit: AuthCubit.instance(),
          ),
        );
      case UserListScreen.route:
        return pageGenerator(
          UserListScreen(
            pageCubit: PageCubit.instance(),
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
