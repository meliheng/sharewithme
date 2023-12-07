import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/home/auth_screen_template.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/Login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthCubit cubit = AuthCubit();
  @override
  Widget build(BuildContext context) {
    return AuthScreenTemplate(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ImageC.appIcon,
            scale: 8,
          ),
          const SizedBox(height: 5),
          Column(
            children: [
              Text(
                StringC.signIn,
                textAlign: TextAlign.center,
                style: const TextStyle(
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
                    return const LoadingGif();
                  } else {
                    return Form(
                      key: cubit.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFieldWithIcon(
                            hintText: StringC.mail,
                            icon: Icons.mail,
                            onChanged: (p0) {
                              cubit.emailChanged(p0);
                            },
                            inputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFieldWithIcon(
                            hintText: StringC.password,
                            icon: Icons.lock,
                            onChanged: (p0) {
                              cubit.passwordChanged(p0);
                            },
                            obscureText: true,
                          ),
                          const SizedBox(height: 10),
                          SubmitButton(
                            title: StringC.signIn,
                            onTap: () {
                              cubit.loginUser(context);
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
    );
  }
}
