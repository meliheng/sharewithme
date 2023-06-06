import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sharewithme/auth/auth_export.dart';
import 'package:sharewithme/user/application/search_cubit/search_state.dart';
import 'package:sharewithme/user/domain/usecase/follow_user_usecase.dart';
import 'package:sharewithme/user/domain/usecase/unfollow_user_usecase.dart';

class SearchCubit extends Cubit<SearchState> {
  final UserEntity userEntity;
  SearchCubit({required this.userEntity}) : super(SearchState.initial()) {
    emit(state.copyWith(userEntity: userEntity));
  }
  void addFollow({required UserEntity userEntity}) async {
    emit(state.copyWith(status: SearchStateStatus.submitting));
    var response =
        await FollowUserUsecase.i.execute(userEntity: userEntity).run();
    response.fold(
      (l) => null,
      (r) {
        emit(state.copyWith(status: SearchStateStatus.success));
        return r;
      },
    );
  }

  void unFollow({required UserEntity userEntity}) async {
    emit(state.copyWith(status: SearchStateStatus.submitting));
    var response =
        await UnFollowUserUsecase.i.execute(userEntity: userEntity).run();
    response.fold(
      (l) => null,
      (r) {
        emit(state.copyWith(status: SearchStateStatus.success));
        return r;
      },
    );
  }

  void onFollowButtonClicked({required String userId}) {
    state.userEntity.followers.add(userId);
    emit(state.copyWith());
  }

  void onUnFollowButtonClicked({required String userId}) {
    state.userEntity.followers.remove(userId);
    emit(state.copyWith());
  }

  void onAboutChanged(String value) {
    emit(
      state.copyWith(
        userEntity: state.userEntity.copyWith(about: value),
      ),
    );
  }

  bool isFollowed() {
    return state.userEntity.followers.any(
      (element) => element == FirebaseAuth.instance.currentUser!.uid,
    );
  }

  static SearchCubit instance({required UserEntity userEntity}) {
    return SearchCubit(userEntity: userEntity);
  }
}
