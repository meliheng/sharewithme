import 'package:flutter/material.dart';

class AuthTitle extends StatelessWidget {
  final String title;
  const AuthTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xff262626),
          fontSize: 48,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
