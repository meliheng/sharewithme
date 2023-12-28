import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';

class AuthCustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const AuthCustomButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SubmitButton(
            title: title,
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
