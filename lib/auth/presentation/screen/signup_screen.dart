import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/constants/style_constant.dart';
import 'package:sharewithme/shared/widgets/password_text_field.dart';

class SignUpPage extends StatefulWidget {
  static const route = '/Signup';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignUpCubit cubit = SignUpCubit();
  @override
  Widget build(BuildContext context) {
    return AuthScreenTemplate(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocConsumer<SignUpCubit, SignUpState>(
            bloc: cubit,
            listener: (context, state) {},
            builder: (context, state) {
              if (state.status.isSubmitting) {
                return const LoadingDialog();
              } else {
                return Form(
                  key: cubit.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.kSignupImage,
                      ),
                      Row(
                        children: [
                          Text(
                            AuthC.signUp,
                            style: StyleConstant.kBlackBold20,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFieldWithIcon(
                        hintText: AuthC.mail,
                        inputType: TextInputType.emailAddress,
                        icon: Icons.mail,
                        onChanged: (p0) {
                          cubit.emailChanged(p0);
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldWithIcon(
                        hintText: AuthC.nickname,
                        onChanged: (p0) {
                          cubit.nicknameChanged(p0);
                        },
                        icon: Icons.person,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      PasswordTextField(
                        hintText: AuthC.password,
                        onChanged: (p0) {
                          cubit.passwordChanged(p0);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(
                              text: AuthC.bySignUpYouareAgreeToOur,
                            ),
                            TextSpan(
                              text: AuthC.termAndCondition,
                              style: StyleConstant.kBlueMediumBold,
                            ),
                            TextSpan(
                              text: AuthC.and,
                            ),
                            TextSpan(
                              text: AuthC.privacyPolicy,
                              style: StyleConstant.kBlueMediumBold,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SubmitButton(
                              title: AuthC.signUp,
                              onTap: () {
                                cubit.createUser(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(text: AuthC.joinUsBefore),
                            const TextSpan(text: " "),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                    context,
                                    LoginScreen.route,
                                  );
                                },
                              text: AuthC.login,
                              style: StyleConstant.kBlueMedium,
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
