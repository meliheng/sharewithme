import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget {
  final Color color;
  final VoidCallback onPressed;
  final IconData icon;
  const CustomIconButton({
    super.key,
    required this.color,
    required this.onPressed,
    required this.icon,
  });

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 0.7).animate(_controller),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: widget.color,
        ),
        child: IconButton(
          constraints: const BoxConstraints(),
          color: Colors.white,
          onPressed: () {
            widget.onPressed();
            _controller.forward();
            Future.delayed(const Duration(milliseconds: 200), () {
              _controller.reverse();
            });
          },
          icon: Icon(widget.icon),
        ),
      ),
    );
  }
}
