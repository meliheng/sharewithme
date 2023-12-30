import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/constants/style_constants.dart';
import 'package:sharewithme/shared/widgets/password_text_field.dart';

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
      showAppBar: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              ImageConstants.loginImage,
              height: MediaQuery.sizeOf(context).height * .3,
            ),
          ),
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
                return const LoadingDialog();
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
                      PasswordTextField(
                        hintText: StringC.password,
                        onChanged: (p0) {
                          cubit.passwordChanged(p0);
                        },
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
