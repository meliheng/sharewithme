import 'package:flutter/material.dart';
import 'package:sharewithme/auth/presentation/screen/login_screen.dart';
import 'package:sharewithme/auth/presentation/screen/signup_screen.dart';
import 'package:sharewithme/shared/_shared_exporter.dart';

class WelcomeScreen extends StatefulWidget {
  static const route = '/welcome';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
                    const Spacer(),
                    Expanded(
                      child: CustomButton(
                        title: "Sign In",
                        color: Colors.amber,
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.route);
                        },
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      child: CustomButton(
                        title: "Create Account",
                        color: Colors.orange,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Apply Now"),
                      ),
                    ),
                    const Spacer(),
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
