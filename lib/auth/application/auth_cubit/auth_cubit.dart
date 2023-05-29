import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sharewithme/auth/domain/usecase/check_apply_usecase.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/user/domain/usecase/add_user_usecase.dart';

import '../../../shared/home/home_screen.dart';

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
        .execute(
            email: state.email,
            password: state.password,
            username: state.nickname)
        .run();
    Future.delayed(const Duration(seconds: 3));
    response.fold(
      (l) {
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
            // getUser();
          },
        );
      },
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
      (r) {
        emit(
          state.copyWith(status: AuthStatus.success, user: r),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomeScreen(authCubit: this);
            },
          ),
          (route) => false,
        );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return HomeScreen(
        //         authCubit: this,
        //       );
        //     },
        //   ),
        // );
        // print(state.user!.email);
      },
    );
  }

  void checkUser(BuildContext context) async {
    emit(state.copyWith(status: AuthStatus.submitting));
    var response = await CheckApplyUsecase.i.execute(email: state.email).run();
    response.fold(
      (l) => null,
      (r) {
        if (r) {
          print("object");
          loginUser(context);
        } else {
          emit(state.copyWith(status: AuthStatus.error));
        }
      },
    );
  }

  void signUpWithGoogle(BuildContext context) async {
    emit(state.copyWith(status: AuthStatus.submitting));
    var response = await SignUpWithGoogle.i
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
      (r) {
        emit(
          state.copyWith(status: AuthStatus.success, user: r),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomeScreen(authCubit: this);
            },
          ),
          (route) => false,
        );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return HomeScreen(
        //         authCubit: this,
        //       );
        //     },
        //   ),
        // );
        // print(state.user!.email);
      },
    );
  }

  void getUser() async {
    print(FirebaseAuth.instance.currentUser!.uid);
    var user = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
          (value) => UserEntity.fromFirestore(value),
        );
    emit(state.copyWith(user: user));
    print(state.user!.email);
  }

  Future logout(BuildContext context) async {
    emit(state.copyWith(status: AuthStatus.submitting));
    var response = await LogoutUsecase.i.execute().run();
    response.fold(
      (l) {
        print(l);
        return null;
      },
      (r) {
        emit(state.copyWith(status: AuthStatus.success));
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return const WelcomeScreen();
        // },),);
      },
    );
  }

  Future<User?> getCurrentUser() async {
    var user = FirebaseAuth.instance.currentUser;
    return user;
  }

  static AuthCubit instance() {
    return AuthCubit();
  }
}
