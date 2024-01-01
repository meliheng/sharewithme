import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sharewithme/user/application/search_cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  late TextEditingController searchController;
  SearchCubit() : super(SearchState.initial()) {
    searchController = TextEditingController();
  }
  void setFilterText() {
    emit(state.copyWith(filterText: searchController.text));
  }

  void setDocuments(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    emit(state.copyWith(documents: docs));
  }

  void filterDocuments() {
    if (state.filterText.isNotEmpty) {
      emit(
        state.copyWith(
          documents: state.documents.where(
            (element) {
              return element
                  .get('username')
                  .toString()
                  .toLowerCase()
                  .contains(state.filterText.toLowerCase());
            },
          ).toList(),
        ),
      );
    }
  }
  // void addFollow({required UserEntity userEntity}) async {
  //   emit(state.copyWith(status: SearchStateStatus.submitting));
  //   var response =
  //       await FollowUserUsecase.i.execute(userEntity: userEntity).run();
  //   response.fold(
  //     (l) => null,
  //     (r) {
  //       emit(state.copyWith(status: SearchStateStatus.success));
  //       return r;
  //     },
  //   );
  // }

  // void unFollow({required UserEntity userEntity}) async {
  //   emit(state.copyWith(status: SearchStateStatus.submitting));
  //   var response =
  //       await UnFollowUserUsecase.i.execute(userEntity: userEntity).run();
  //   response.fold(
  //     (l) => null,
  //     (r) {
  //       emit(state.copyWith(status: SearchStateStatus.success));
  //       return r;
  //     },
  //   );
  // }

  // void onFollowButtonClicked({required String userId}) {
  //   state.userEntity.followers.add(userId);
  //   emit(state.copyWith());
  // }

  // void onUnFollowButtonClicked({required String userId}) {
  //   state.userEntity.followers.remove(userId);
  //   emit(state.copyWith());
  // }

  // void onAboutChanged(String value) {
  //   emit(
  //     state.copyWith(
  //       userEntity: state.userEntity.copyWith(about: value),
  //     ),
  //   );
  // }

  // bool isFollowed() {
  //   return state.userEntity.followers.any(
  //     (element) => element == FirebaseAuth.instance.currentUser!.uid,
  //   );
  // }
}
