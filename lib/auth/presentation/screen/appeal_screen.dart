// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:file_picker/file_picker.dart';
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
      body: SingleChildScrollView(
        child: Center(
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
                        onChanged: (p0) {
                          context.read<ApplyCubit>().fullnameChanged(p0);
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
                        hintText: "School",
                        onChanged: (p0) {
                          context.read<ApplyCubit>().schoolChanged(p0);
                        },
                        icon: Icons.school,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWithIcon(
                        hintText: "Department",
                        icon: Icons.work,
                        onChanged: (p0) {
                          context.read<ApplyCubit>().departmentChanged(p0);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWithIcon(
                        hintText: "Mail",
                        icon: Icons.mail,
                        onChanged: (p0) {
                          context.read<ApplyCubit>().fullnameChanged(p0);
                        },
                        validator: (p0) {
                          if (!isEmailValid(p0!)) {
                            return 'sacmalama';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();
                          if (result != null) {
                            File file = File(result.files.first.path ?? '');
                            if (!mounted) {
                              return;
                            }
                            context.read<ApplyCubit>().onFileSelected(file);
                          }
                        },
                        child: const Text('Select File'),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Forgot  your password?",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Color(0xffbebebe),
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SubmitButton(
                            title: "Submit",
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<ApplyCubit>().newApply();
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
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
      ),
    );
  }
}

mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length == 6;

  bool isEmailValid(String email) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.edu+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }
}
