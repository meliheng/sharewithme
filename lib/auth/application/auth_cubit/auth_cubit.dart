import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sharewithme/auth/domain/usecase/create_user_usecase.dart';
import 'package:sharewithme/user/domain/usecase/add_user_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());

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

  void nicknameChanged(String value) {
    emit(
      state.copyWith(
        nickname: value,
      ),
    );
  }

  void createUser(BuildContext context) async {
    emit(state.copyWith(status: AuthStatus.submitting));
    var response = await CreateUserUsecase.i
        .execute(email: state.email, password: state.password)
        .run();
    Future.delayed(const Duration(seconds: 3));
    response.fold(
      (l) {
        print(l);
        emit(state.copyWith(status: AuthStatus.error));
        if (state.status == AuthStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Böyle bir hesap zaten mevcut'),
            ),
          );
        }
      },
      (r) async {
        var response2 = await AddUserUsecase.i.execute(userEntity: r).run();
        response2.fold(
          (l) => print(l),
          (r) {
            emit(
              state.copyWith(status: AuthStatus.success),
            );
          },
        );
      },
    );
  }
}
