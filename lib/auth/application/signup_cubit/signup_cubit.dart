import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/user/domain/repository/i_user_repository.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final formKey = GlobalKey<FormState>();

  final IAuthRepository authRepository = IAuthRepository.i;
  final IUserRepository userRepository = IUserRepository.i;

  SignUpCubit() : super(SignUpState.initial());

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: value,
      ),
    );
  }

  void avatarSelected(File file) {
    emit(
      state.copyWith(
        avatar: file,
      ),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
      ),
    );
  }

  void nicknameChanged(String value) {
    emit(
      state.copyWith(
        nickname: value,
      ),
    );
  }

  void createUser(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(status: Status.submitting));
      var response = await CreateUserUsecase.i
          .execute(
            email: state.email,
            password: state.password,
            username: state.nickname,
          )
          .flatMap(
            (r) => userRepository.add(userEntity: r),
          )
          .flatMap(
            (r) => authRepository.addProfileImage(
              email: state.email,
              file: state.avatar,
            ),
          )
          .run();
      Future.delayed(const Duration(seconds: 3));
      response.fold(
        (l) {
          emit(state.copyWith(status: Status.error));
          if (state.status == Status.error) {
            CustomDialog.error(
              context: context,
              message: l.message,
            );
          }
        },
        (r) async {
          emit(
            state.copyWith(status: Status.success),
          );
          CustomDialog.success(
            context: context,
            message: AuthC.accountCreated,
            onSubmit: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenTemplate(),
                ),
                (route) => false,
              );
            },
          );
        },
      );
    }
  }
}
