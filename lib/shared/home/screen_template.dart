import 'package:flutter/material.dart';
import 'package:sharewithme/custom_navigation_bar.dart';
import 'package:sharewithme/shared/constants/color_constants.dart';

class ScreenTemplate extends StatelessWidget {
  final Widget body;
  final bool showNavigationBar;
  const ScreenTemplate({
    super.key,
    required this.body,
    this.showNavigationBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: body,
      ),
      bottomNavigationBar:
          showNavigationBar ? const CustomNavigationBar() : null,
    );
  }
}
