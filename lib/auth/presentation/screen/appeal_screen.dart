// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/auth/application/apply_cubit/apply_cubit.dart';
import 'package:sharewithme/export.dart';

class AppealPage extends StatefulWidget {
  const AppealPage({super.key});

  @override
  State<AppealPage> createState() => _AppealPageState();
}

class _AppealPageState extends State<AppealPage> with InputValidationMixin {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 200,
                child: Text(
                  "Share With Me",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff262626),
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Apply Now",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff262626),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFieldWithIcon(
                      hintText: "Fullname",
                      icon: Icons.person,
                      validator: (p0) {
                        if (p0 == '') {
                          return 'boş olamaz';
                        } else if (isEmailValid(p0!)) {
                          return null;
                        } else {
                          return 'geçersiz';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const TextFieldWithIcon(
                        hintText: "School", icon: Icons.school),
                    const SizedBox(
                      height: 20,
                    ),
                    const TextFieldWithIcon(
                        hintText: "Department", icon: Icons.work),
                    const SizedBox(height: 5),
                    BlocBuilder<ApplyCubit, ApplyState>(
                      bloc: ApplyCubit(),
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () async {
                            _formKey.currentState!.validate();
                          },
                          child: const Text('Select File'),
                        );
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "Forgot  your password?",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Color(0xffbebebe),
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SubmitButton(title: "Submit"),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 200),
              const SizedBox(
                width: 209,
                height: 24,
                child: Text(
                  "Don’t have an account? Create",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff262626),
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length == 6;

  bool isEmailValid(String email) {
    return true;
  }
}
