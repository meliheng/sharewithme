import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color color;
  final void Function()? onPressed;
  final double radius;
  const CustomButton({
    super.key,
    required this.title,
    required this.color,
    this.onPressed,
    this.radius = 0,
  });
  bool get withBorder => radius != 0;
  factory CustomButton.withRadius({
    required String title,
    required Color color,
    required void Function()? onPressed,
  }) {
    return CustomButton(
      title: title,
      color: color,
      onPressed: onPressed,
      radius: 16,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: withBorder
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                )
              : null,
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
