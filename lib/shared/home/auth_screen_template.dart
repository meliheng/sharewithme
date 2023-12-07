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
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 100,
            height: MediaQuery.of(context).size.height,
            child: body,
          ),
        ),
      ),
    );
  }
}
