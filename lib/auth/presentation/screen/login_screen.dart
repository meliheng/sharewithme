import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/constants/style_constants.dart';
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(ImageConstants.loginImage),
          Text(
            StringC.signIn,
            style: StyleContants.blackBold20,
          ),
          const SizedBox(height: 10),
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
                        height: 30,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            AuthStringConstants.forgetPassword,
                            textAlign: TextAlign.end,
                            style: StyleContants.blueMediumBold,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      AuthCustomButton(
                        title: StringC.signIn,
                        onTap: () {
                          cubit.loginUser(context);
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomDivider(
                        content: AuthStringConstants.or,
                      ),
                      const SizedBox(height: 20),
                      const GoogleButton(),
                      const SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(text: AuthStringConstants.newToHere),
                            const TextSpan(text: " "),
                            TextSpan(
                              text: AuthStringConstants.register,
                              style: StyleContants.blueMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
