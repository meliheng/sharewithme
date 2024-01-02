import 'package:flutter/material.dart';

class AnimatedNavigationButton extends StatefulWidget {
  final Function() onTap;
  final Widget icon;
  const AnimatedNavigationButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  State<AnimatedNavigationButton> createState() =>
      _AnimatedNavigationButtonState();
}

class _AnimatedNavigationButtonState extends State<AnimatedNavigationButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool shouldAnimate = false;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 450),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.addListener(
      () {
        if (_animationController.isAnimating) {
          _animationController.stop();
        }
      },
    );
    return Material(
      child: InkWell(
        onTap: () async {
          widget.onTap();
          await _animationController.repeat();
          _animationController.stop();
        },
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
          child: widget.icon,
        ),
      ),
    );
  }
}
