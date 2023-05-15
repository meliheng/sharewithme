import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/user/domain/usecase/follow_user_usecase.dart';

import '../../domain/usecase/get_all_user_usecase.dart';

part 'user_list_state.dart';

class UserListCubit extends Cubit<UserListState> {
  UserListCubit() : super(UserListState.initial());

  void getUsers(BuildContext context) async {
    emit(state.copyWith(status: UserListStatus.submitting));
    var response = await GetAllUserUsecase.i.execute().run();
    response.fold(
      (l) {
        emit(state.copyWith(status: UserListStatus.error));
        if (state.status == UserListStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Birşeyler yanlış gitti 🧐'),
            ),
          );
        }
      },
      (r) {
        emit(
          state.copyWith(status: UserListStatus.success, userList: r,filteredUserList: r),
        );
      },
    );
  }

  void applyFilter({required String value}) {
    if (value.isEmpty) {
      print("empty");
      emit(
        state.copyWith(filteredUserList: state.userList),
      );
    }else {
    List<UserEntity> filteredList =
       state.userList.filter((t) => t.email.contains(value)).toList();
    emit(
      state.copyWith(filteredUserList: filteredList),
    );

    }
  }

  void addFollow({required UserEntity userEntity}) async {
    emit(state.copyWith(status: UserListStatus.submitting));
    var response =
        await FollowUserUsecase.i.execute(userEntity: userEntity).run();
    response.fold(
      (l) => null,
      (r) {
        emit(state.copyWith(status: UserListStatus.success));
        return r;
      },
    );
  }

  void filterTextChanged(String value) {
    emit(
      state.copyWith(filterText: value),
    );
    applyFilter(value: state.filterText);
  }

  bool isFollowed({required UserEntity userEntity}) {
    return userEntity.followers
        .any((element) => element == FirebaseAuth.instance.currentUser!.uid);
  }

  static UserListCubit instance() {
    return UserListCubit();
  }
}
