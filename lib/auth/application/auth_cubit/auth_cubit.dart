import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/home/screen_template.dart';
import 'package:sharewithme/user/domain/repository/i_user_repository.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final formKey = GlobalKey<FormState>();

  final IAuthRepository authRepository = IAuthRepository.i;
  final IUserRepository userRepository = IUserRepository.i;

  AuthCubit() : super(AuthState.initial());

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

  void loginUser(BuildContext context) async {
    emit(state.copyWith(status: AuthStatus.submitting));
    var response = await LoginUsecase.i
        .execute(email: state.email, password: state.password)
        .run();
    Future.delayed(const Duration(seconds: 3));
    response.fold(
      (l) {
        emit(state.copyWith(status: AuthStatus.error));
        if (state.status == AuthStatus.error) {
          CustomDialog.error(
            context: context,
            message: l.message,
          );
        }
      },
      (r) {
        emit(
          state.copyWith(status: AuthStatus.success),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const ScreenTemplate();
            },
          ),
          (route) => false,
        );
      },
    );
  }

  // void getUser() async {
  //   var user = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .then(
  //         (value) => UserEntity.fromFirestore(value),
  //       );
  //   emit(state.copyWith(user: user));
  // }

  // Future logout(BuildContext context) async {
  //   emit(state.copyWith(status: AuthStatus.submitting));
  //   var response = await LogoutUsecase.i.execute().run();
  //   response.fold(
  //     (l) {
  //       print(l);
  //       return null;
  //     },
  //     (r) {
  //       emit(state.copyWith(status: AuthStatus.success));
  //       // Navigator.push(context, MaterialPageRoute(builder: (context) {
  //       //   return const WelcomeScreen();
  //       // },),);
  //     },
  //   );
  // }

  // Future deleteAccount(BuildContext context) async {
  //   emit(state.copyWith(status: AuthStatus.submitting));
  //   await FirebaseAuth.instance.currentUser!.delete();
  //   emit(state.copyWith(status: AuthStatus.success));
  // }

  // Future<User?> getCurrentUser() async {
  //   var user = FirebaseAuth.instance.currentUser;
  //   return user;
  // }
}
