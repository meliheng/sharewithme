import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/auth/presentation/avatar_widget.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/home/auth_screen_template.dart';

class SignUpPage extends StatefulWidget {
  static const route = '/Signup';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthCubit cubit = AuthCubit();
  @override
  Widget build(BuildContext context) {
    return AuthScreenTemplate(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringC.signUp,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff262626),
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 40),
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
                      CircularAvatarWithEditIcon(
                        image: cubit.state.imagePath,
                        onFileSelected: cubit.avatarSelected,
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
                      const SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          SubmitButton(
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
                        ],
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
