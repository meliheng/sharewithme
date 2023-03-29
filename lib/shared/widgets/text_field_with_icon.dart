import 'package:flutter/material.dart';

class TextFieldWithIcon extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  const TextFieldWithIcon({
    Key? key,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          hintText: hintText,
          hintStyle: const TextStyle(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue.shade300),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 0,
            ),
          ),
        ),
      ),
    );
  }
}
