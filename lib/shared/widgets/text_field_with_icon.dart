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
      validator: validator,
      onChanged: onChanged,
      keyboardType: inputType,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: ColorConstants.primaryOrange,
        ),
        filled: true,
        fillColor: ColorConstants.primaryOrange.withOpacity(.2),
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
        hintText: hintText,
        hintStyle: const TextStyle(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.primaryOrange, width: 2),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade700),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade700),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorConstants.primaryOrange,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
