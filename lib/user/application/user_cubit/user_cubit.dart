import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sharewithme/auth/auth_export.dart';
import 'package:sharewithme/user/application/user_cubit/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserEntity userEntity;
  UserCubit({required this.userEntity}) : super(UserState.initial()) {
    emit(state.copyWith(userEntity: userEntity));
  }

  void addAbout(BuildContext context) async {
    emit(state.copyWith(status: UserStateStatus.initial));
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(
      {"about": state.userEntity.about},
    );
    emit(state.copyWith(status: UserStateStatus.success,userEntity: state.userEntity.copyWith()));
    Navigator.pop(context);
  }

  void onAboutChanged(String value) {
    emit(
      state.copyWith(
        userEntity: state.userEntity.copyWith(about: value),
      ),
    );
  }

  static UserCubit instance({required UserEntity userEntity}) {
    return UserCubit(userEntity: userEntity);
  }
}
