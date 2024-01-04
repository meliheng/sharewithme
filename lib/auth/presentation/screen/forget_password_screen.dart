import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/constants/style_constant.dart';
import 'package:sharewithme/shared/widgets/password_text_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const route = '/ForgetPassword';
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final AuthCubit cubit = AuthCubit();
  @override
  Widget build(BuildContext context) {
    return AuthScreenTemplate(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(ImageConstant.kLoginImage),
          Text(
            AuthC.signIn,
            style: StyleContant.kBlackBold20,
          ),
          const SizedBox(height: 10),
          BlocConsumer<AuthCubit, AuthState>(
            bloc: cubit,
            listener: (context, state) {},
            builder: (context, state) {
              if (state.status == AuthStatus.submitting) {
                return const LoadingDialog();
              } else {
                return Form(
                  key: cubit.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFieldWithIcon(
                        hintText: AuthC.mail,
                        icon: Icons.mail,
                        onChanged: (p0) {
                          cubit.emailChanged(p0);
                        },
                        inputType: TextInputType.emailAddress,
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
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            AuthC.forgetPassword,
                            textAlign: TextAlign.end,
                            style: StyleContant.kBlueMediumBold,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      AuthCustomButton(
                        title: AuthC.signIn,
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
                              style: StyleContant.kBlueMedium,
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
