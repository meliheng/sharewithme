import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/constants/style_constants.dart';

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
                return const LoadingGif();
              } else {
                return Form(
                  key: cubit.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(ImageConstants.signupImage),
                      // CircularAvatarWithEditIcon(
                      //   file: cubit.state.avatar,
                      //   onFileSelected: cubit.avatarSelected,
                      // ),
                      Row(
                        children: [
                          Text(
                            StringC.signUp,
                            style: StyleContants.blackBold20,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFieldWithIcon(
                        hintText: StringC.mail,
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
                        hintText: StringC.nickname,
                        onChanged: (p0) {
                          cubit.nicknameChanged(p0);
                        },
                        icon: Icons.person,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldWithIcon(
                        hintText: StringC.password,
                        obscureText: true,
                        icon: Icons.lock,
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
                              text:
                                  AuthStringConstants.bySignUpYouareAgreeToOur,
                            ),
                            TextSpan(
                              text: AuthStringConstants.termAndCondition,
                              style: StyleContants.blueMediumBold,
                            ),
                            TextSpan(
                              text: AuthStringConstants.and,
                            ),
                            TextSpan(
                              text: AuthStringConstants.privacyPolicy,
                              style: StyleContants.blueMediumBold,
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
                              title: StringC.signUp,
                              onTap: () {
                                cubit.createUser(context);
                                // if (_formKey.currentState!.validate()) {
                                //   cubit.checkUser(context);
                                //   // cubit.getUser();

                                //   // Navigator.pushAndRemoveUntil(context,
                                //   //     MaterialPageRoute(
                                //   //   builder: (context) {
                                //   //     return HomeScreen(
                                //   //       authCubit: cubit,
                                //   //     );
                                //   //   },
                                //   // ), (route) => false);
                                // }
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
                            TextSpan(text: AuthStringConstants.joinUsBefore),
                            const TextSpan(text: " "),
                            TextSpan(
                              text: StringConstants.login,
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
