import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/user/presentation/user_list_screen.dart';

class RouterManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.route:
        return pageGenerator(const LoginScreen());
      case HomeScreen.route:
        return pageGenerator(const HomeScreen());
      case ActivityScreen.route:
        return pageGenerator(const ActivityScreen());
      case UserListScreen.route:
        return pageGenerator(const UserListScreen());
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
