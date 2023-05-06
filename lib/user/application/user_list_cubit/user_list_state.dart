part of 'user_list_cubit.dart';

enum UserListStatus { initial, submitting, success, error }

class UserListState {
  final UserListStatus status;
  final List<UserEntity> userList;
  UserListState({
    required this.status,
    required this.userList,
  });
  factory UserListState.initial() {
    return UserListState(
      status: UserListStatus.initial,
      userList: [],
    );
  }

  UserListState copyWith({
    UserListStatus? status,
    List<UserEntity>? userList,
  }) {
    return UserListState(
      status: status ?? this.status,
      userList: userList ?? this.userList,
    );
  }

  @override
  bool operator ==(covariant UserListState other) {
    return other.status == status && userList == other.userList;
  }

  @override
  int get hashCode => status.hashCode ^ userList.hashCode;
}
