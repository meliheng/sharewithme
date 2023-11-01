import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sharewithme/auth/application/apply_cubit/apply_state.dart';
import 'package:sharewithme/auth/domain/model/appeal_entity.dart';
import 'package:sharewithme/auth/domain/usecase/apply_usecase.dart';
import 'package:sharewithme/shared/_shared_exporter.dart';

class ApplyCubit extends Cubit<ApplyState> {
  String get fileName => state.file.path.split('/').last;
  ApplyCubit() : super(ApplyState.initial());

  void fullnameChanged(String value) {
    emit(
      state.copyWith(
        fullname: value,
        status: ApplyStatus.initial,
      ),
    );
  }

  void schoolChanged(String value) {
    emit(
      state.copyWith(
        school: value,
        status: ApplyStatus.initial,
      ),
    );
  }

  void departmentChanged(String value) {
    emit(
      state.copyWith(
        department: value,
        status: ApplyStatus.initial,
      ),
    );
  }

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: value,
        status: ApplyStatus.initial,
      ),
    );
  }

  void onFileSelected() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.first.path ?? '');
      // if (!mounted) {
      //   return;
      // }
      emit(state.copyWith(file: file, status: ApplyStatus.initial));
    }
  }

  bool isPasswordValid(String password) => password.length == 6;

  bool isEmailValid(String email) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.edu+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  void newApply(BuildContext context) async {
    emit(state.copyWith(status: ApplyStatus.submitting));
    var response = await ApplyUsecase.i
        .execute(
          appealEntity: AppealEntity(
            fullname: Name.create(state.fullname),
            school: Name.create(state.school),
            department: Name.create(state.department),
            email: state.email,
            file: state.file,
          ),
        )
        .run();
    if (state.status == ApplyStatus.submitting) {
      // ignore: use_build_context_synchronously
    }
    Future.delayed(const Duration(seconds: 2));

    response.fold((l) {
      emit(state.copyWith(status: ApplyStatus.error));
    }, (r) {
      emit(state.copyWith(status: ApplyStatus.success));
    });
  }

  static ApplyCubit instance() {
    return ApplyCubit();
  }
}
