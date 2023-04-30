import 'package:flutter/material.dart';
import 'package:sharewithme/auth/presentation/screen/login_screen.dart';
import 'package:sharewithme/auth/presentation/screen/signup_screen.dart';
import 'package:sharewithme/shared/_shared_exporter.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/app_icon.png',
              scale: 8,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Spacer(),
                    Expanded(
                      child: CustomButton(
                        title: "Sign In",
                        color: Colors.amber,
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.route);
                        },
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                Row(
                  children: [
                    Spacer(),
                    Expanded(
                      child: CustomButton(
                        title: "Create Account",
                        color: Colors.orange,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                Row(
                  children: [
                    Spacer(),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Apply Now"),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
