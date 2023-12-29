import 'package:flutter/material.dart';

class AuthScreenTemplate extends StatelessWidget {
  final Widget body;
  const AuthScreenTemplate({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: body,
          ),
        ),
      ),
    );
  }
}
