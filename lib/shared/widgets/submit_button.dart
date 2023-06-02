import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const SubmitButton({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorConstants.primaryOrange,
            ),
            child: const Text(
              "Sign In",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
