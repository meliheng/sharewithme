import 'package:flutter/material.dart';

class TextFieldWithIcon extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? inputType;
  const TextFieldWithIcon({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.onChanged,
    this.validator,
    this.inputType,
    this.obscureText = false,
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
            boxShadow: [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 20,
                offset: Offset(0, 8),
              )
            ],
          ),
        ),
        TextFormField(
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
          keyboardType: inputType,
          style: const TextStyle(decorationThickness: 0),
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
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
