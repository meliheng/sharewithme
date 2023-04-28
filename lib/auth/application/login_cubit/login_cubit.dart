import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial());

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: value,
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

  void loginUser(BuildContext context) async {
    emit(state.copyWith(status: LoginStatus.submitting));
    var response = await LoginUsecase.i
        .execute(email: state.email, password: state.password)
        .run();
    Future.delayed(const Duration(seconds: 3));
    response.fold(
      (l) {
        print(l);
        emit(state.copyWith(status: LoginStatus.error));
        if (state.status == LoginStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Böyle bir hesap zaten mevcut'),
            ),
          );
        }
      },
      (r) => emit(
        state.copyWith(status: LoginStatus.success),
      ),
    );
  }

  Future<User?> getCurrentUser() async {
    var user = FirebaseAuth.instance.currentUser;
    return user;
  }
}
