import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            'assets/icons/app_icon.png',
            scale: 8,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Sign In"),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Create Account"),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Apply Now"),
          ),
        ],
      ),
    );
  }
}
