import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';

class AppTheme {
  static ThemeData appTheme() {
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorConstants.primaryBlue,
            width: 2,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorConstants.grayV1,
            width: 2,
          ),
        ),
      ),
    );
  }
}
