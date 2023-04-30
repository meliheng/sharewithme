import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';

class RouterManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.route:
        return pageGenerator(LoginScreen());
      case HomeScreen.route:
        return pageGenerator(HomeScreen());
      case ActivityScreen.route:
        return pageGenerator(ActivityScreen());
      default:
        return pageGenerator(Text("error"));
    }
  }

  static pageGenerator(Widget widget) {
    return MaterialPageRoute(
      builder: (_) => widget,
    );
  }
}
