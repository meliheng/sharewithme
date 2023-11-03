import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/auth/application/apply_cubit/apply_state.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/home/screen_template.dart';

class AppealPage extends StatefulWidget {
  static const route = '/Appeal';

  const AppealPage({super.key});

  @override
  State<AppealPage> createState() => _AppealPageState();
}

class _AppealPageState extends State<AppealPage> {
  final ApplyCubit cubit = ApplyCubit();
  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      showNavigationBar: false,
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          height: MediaQuery.of(context).size.height,
          child: BlocConsumer<ApplyCubit, ApplyState>(
            bloc: cubit,
            listener: (context, state) {
              // if (state.status == ApplyStatus.submitting) {
              //   CoolAlert.show(
              //     context: context,
              //     type: CoolAlertType.loading,
              //     autoCloseDuration: const Duration(seconds: 2),
              //   );
              // }
              // if (state.status == ApplyStatus.success) {
              //   Navigator.pop(context);
              // }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AuthTitle(
                    title: "Share With Me",
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
                    key: cubit.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFieldWithIcon(
                          hintText: AuthC.fullname,
                          icon: Icons.person,
                          onChanged: (p0) {
                            cubit.fullnameChanged(p0);
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
                          hintText: AuthC.school,
                          onChanged: (p0) {
                            cubit.schoolChanged(p0);
                          },
                          icon: Icons.school,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldWithIcon(
                          hintText: AuthC.department,
                          icon: Icons.work,
                          onChanged: (p0) {
                            cubit.departmentChanged(p0);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldWithIcon(
                          hintText: AuthC.mail,
                          icon: Icons.mail,
                          onChanged: (p0) {
                            cubit.emailChanged(p0);
                          },
                          validator: (p0) {
                            return Email.create(p0!).validate();
                          },
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            if (cubit.fileName.isNotEmpty)
                              Expanded(child: Text(cubit.fileName)),
                            Expanded(
                              child: CustomButton(
                                onPressed: () {
                                  cubit.onFileSelected();
                                },
                                color: Colors.black,
                                title: AuthC.selectFile,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AuthC.forgotYourPassword,
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                color: Color(0xffbebebe),
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SubmitButton(
                              title: AuthC.submit,
                              onTap: () {
                                cubit.newApply(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
