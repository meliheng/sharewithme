import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sharewithme/auth/application/apply_cubit/apply_state.dart';
import 'package:sharewithme/auth/domain/model/appeal_entity.dart';
import 'package:sharewithme/auth/domain/repository/i_auth_repository.dart';
import 'package:sharewithme/shared/_shared_exporter.dart';

class ApplyCubit extends Cubit<ApplyState> {
  final IAuthRepository authRepository = IAuthRepository.i;
  String get fileName => model.file.path.split('/').last;
  AppealEntity get model => state.appealEntity;
  ApplyCubit() : super(ApplyState.initial());

  void fullnameChanged(String value) {
    model.fullname = Name.create(value);
  }

  void schoolChanged(String value) {
    model.school = Name.create(value);
  }

  void departmentChanged(String value) {
    model.department = Name.create(value);
  }

  void emailChanged(String value) {
    model.email = value;
  }

  void onFileSelected() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.first.path ?? '');
      model.file = file;
      redraw();
      // if (!mounted) {
      //   return;
      // }
    }
  }

  void redraw() {
    emit(state.copyWith());
  }

  bool isPasswordValid(String password) => password.length == 6;

  bool isEmailValid(String email) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.edu+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  final formKey = GlobalKey<FormState>();

  void newApply(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(status: ApplyStatus.submitting));
      var response =
          await authRepository.validateEmail(email: model.email).flatMap(
        (r) {
          return authRepository.apply(
            appealEntity: model,
          );
        },
      ).run();
      // var response = await authRepository
      //     .apply(
      //       appealEntity: AppealEntity(
      //         fullname: Name.create(state.fullname),
      //         school: Name.create(state.school),
      //         department: Name.create(state.department),
      //         email: state.email,
      //         file: state.file,
      //       ),
      //     )
      //     .run();
      Future.delayed(const Duration(seconds: 2));

      response.fold(
        (l) {
          emit(state.copyWith(status: ApplyStatus.error));
          CustomDialog.error(
            context: context,
            message: l.message,
          );
        },
        (r) {
          emit(state.copyWith(status: ApplyStatus.success));
          EmailService.sendEmail(email: model.email);
          Navigator.pop(context);
        },
      );
    }
  }
}
