import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sharewithme/export.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/Login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthCubit cubit = AuthCubit.instance();
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
                      "Sign In",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff262626),
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocConsumer<AuthCubit, AuthState>(
                      bloc: cubit,
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
                                    cubit.emailChanged(p0);
                                  },
                                  validator: (p0) {
                                    return Email.create(p0!).validate();
                                  },
                                  inputType: TextInputType.emailAddress,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFieldWithIcon(
                                  hintText: "Password",
                                  icon: Icons.lock,
                                  onChanged: (p0) {
                                    cubit.passwordChanged(p0);
                                  },
                                  obscureText: true,
                                ),
                                const SizedBox(height: 10),
                                SubmitButton(
                                  title: "Sign In",
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      cubit.loginUser(context);
                                    }
                                  },
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
