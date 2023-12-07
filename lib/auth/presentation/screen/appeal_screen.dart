import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/auth/application/apply_cubit/apply_state.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/home/auth_screen_template.dart';

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
    return AuthScreenTemplate(
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
              if (state.status == ApplyStatus.submitting) {
                return const LoadingGif();
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AuthTitle(
                      title: StringC.appName,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      StringC.applyNow,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
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
                            // validator: Validator.nameValidator,
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
                            // validator: Validator.nameValidator,
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
                            // validator: Validator.nameValidator,
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
                            validator: cubit.validateEmail,
                            // validator: (p0) {
                            //   return Email.create(p0!).validate();
                            // },
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              if (cubit.fileName.isNotEmpty)
                                Expanded(
                                  child: Text(cubit.fileName),
                                ),
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
              }
            },
          ),
        ),
      ),
    );
  }
}
