// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sharewithme/auth/presentation/screen/appeal_screen.dart';

void main(List<String> args) {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Lato'),
      home: const AppealPage(),
    );
  }
}
