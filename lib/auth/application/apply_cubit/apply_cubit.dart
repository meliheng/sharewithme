import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/auth/domain/model/appeal_entity.dart';
import 'package:sharewithme/auth/domain/usecase/apply_usecase.dart';
import 'package:sharewithme/shared/_shared_exporter.dart';

part 'apply_state.dart';

class ApplyCubit extends Cubit<ApplyState> {
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

  void onFileSelected(File file) {
    emit(state.copyWith(file: file, status: ApplyStatus.initial));
  }

  void newApply() async {
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
    response.fold((l) {
      print(l.message);
      emit(state.copyWith(status: ApplyStatus.error));
    }, (r) {
      emit(state.copyWith(status: ApplyStatus.success));
    });
  }
}
