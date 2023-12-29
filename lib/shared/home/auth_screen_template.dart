import 'package:flutter/material.dart';

class AuthScreenTemplate extends StatelessWidget {
  final Widget body;
  final bool showAppBar;
  const AuthScreenTemplate({
    super.key,
    required this.body,
    this.showAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              elevation: 0,
              iconTheme: const IconThemeData(
                color: Colors.black, //change your color here
              ),
              backgroundColor: Colors.transparent,
            )
          : null,
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
