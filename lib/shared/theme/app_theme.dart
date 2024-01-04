import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';

class AppTheme {
  static ThemeData appTheme() {
    return ThemeData(
      fontFamily: 'Poppins',
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorConstant.kPrimaryBlue,
            width: 2,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorConstant.kGrayV1,
            width: 2,
          ),
        ),
      ),
    );
  }
}
