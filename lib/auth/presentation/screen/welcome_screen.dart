import 'package:flutter/material.dart';
import 'package:sharewithme/auth/application/navigation/navigation_cubit.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/home/auth_screen_template.dart';

class AuthScreen extends StatefulWidget {
  static const route = '/welcome';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var cb = NavigationCubit();
  @override
  Widget build(BuildContext context) {
    return AuthScreenTemplate(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ImageC.appIcon,
            scale: 8,
          ),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      title: StringC.signIn,
                      color: const Color.fromARGB(255, 39, 67, 86),
                      onPressed: () {
                        cb.onLoginPressed(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      title: StringC.createAccount,
                      color: const Color.fromARGB(255, 55, 85, 67),
                      onPressed: () {
                        cb.onSignUpPressed(context);
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // Expanded(
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => const AppealPage(),
                  //         ),
                  //       );
                  //     },
                  //     child: const Text("Apply Now"),
                  //   ),
                  // ),
                  Expanded(
                    child: CustomButton(
                      title: StringC.applyNow,
                      color: const Color(0xfff39c12),
                      onPressed: () {
                        cb.onAppealPressed(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
