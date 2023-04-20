import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/export.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 100,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const AuthTitle(
                //   title: "Share With Me",
                // ),
                Image.asset(
                  'assets/icons/app_icon.png',
                  scale: 8,
                ),
                const SizedBox(height: 5),
                Column(
                  children: [
                    const Text(
                      "Create Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff262626),
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state.status == AuthStatus.submitting) {
                          return const CircularProgressIndicator();
                        } else {
                          return Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextFieldWithIcon(
                                  hintText: "Mail",
                                  icon: Icons.mail,
                                  onChanged: (p0) {
                                    context.read<AuthCubit>().emailChanged(p0);
                                  },
                                  validator: (p0) {
                                    if (p0 == '') {
                                      return 'boş olamaz';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFieldWithIcon(
                                  hintText: "Nickname",
                                  onChanged: (p0) {
                                    context
                                        .read<AuthCubit>()
                                        .nicknameChanged(p0);
                                  },
                                  icon: Icons.person,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFieldWithIcon(
                                  hintText: "Password",
                                  icon: Icons.lock,
                                  onChanged: (p0) {
                                    context
                                        .read<AuthCubit>()
                                        .passwordChanged(p0);
                                  },
                                ),
                                const SizedBox(height: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SubmitButton(
                                      title: "Sign Up",
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          context
                                              .read<AuthCubit>()
                                              .createUser(context);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// mixin InputValidationMixin {
//   bool isPasswordValid(String password) => password.length == 6;

//   bool isEmailValid(String email) {
//     final bool emailValid = RegExp(
//             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.edu+\.[a-zA-Z]+")
//         .hasMatch(email);
//     return emailValid;
//   }
// }
