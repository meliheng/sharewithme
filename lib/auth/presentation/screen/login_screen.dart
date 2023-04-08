import 'package:flutter/material.dart';
import 'package:sharewithme/shared/widgets/submit_button.dart';
import 'package:sharewithme/shared/widgets/text_field_with_icon.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 200,
                child: Text(
                  "Share With Me",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff262626),
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Sign in to your account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff262626),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFieldWithIcon(
                    hintText: "Username",
                    icon: Icons.person,
                    onChanged: (p0) {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWithIcon(
                    hintText: "Password",
                    icon: Icons.lock,
                    onChanged: (p0) {},
                    obscureText: true,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Forgot  your password?",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Color(0xffbebebe),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SubmitButton(title: "Sign in")
                ],
              ),
              const SizedBox(height: 200),
              const SizedBox(
                width: 209,
                height: 24,
                child: Text(
                  "Don’t have an account? Create",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff262626),
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
