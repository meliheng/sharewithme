import 'package:flutter/material.dart';

class TextFieldWithIcon2 extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  const TextFieldWithIcon2({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.onChanged,
    this.validator,
    this.obscureText = false, this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        TextFormField(
          initialValue: initialValue,
          obscureText: obscureText,
          validator: validator,
          maxLines: 5,
          onChanged: onChanged,
          style: const TextStyle(decorationThickness: 0),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            hintText: hintText,
            hintStyle: const TextStyle(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue.shade700),
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
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
                width: 0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
