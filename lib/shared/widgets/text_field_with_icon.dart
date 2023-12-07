import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';

class TextFieldWithIcon extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? inputType;
  final TextEditingController? controller;
  const TextFieldWithIcon({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.onChanged,
    this.validator,
    this.inputType,
    this.obscureText = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      onChanged: onChanged,
      keyboardType: inputType,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.greenV1),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.grayV1),
        ),
      ),
    );
  }
}
