part of 'user_list_cubit.dart';

enum UserListStatus { initial, submitting, success, error }

class UserListState {
  final UserListStatus status;
  final List<UserEntity> userList;
  final List<UserEntity> filteredUserList;
  final String filterText;
  UserListState({
    required this.status,
    required this.userList,
    required this.filterText,
    required this.filteredUserList,
  });
  factory UserListState.initial() {
    return UserListState(
      status: UserListStatus.initial,
      userList: [],
      filteredUserList: [],
      filterText: "",
    );
  }

  UserListState copyWith({
    UserListStatus? status,
    List<UserEntity>? userList,
    List<UserEntity>? filteredUserList,
    String? filterText,
  }) {
    return UserListState(
      status: status ?? this.status,
      userList: userList ?? this.userList,
      filterText: filterText ?? this.filterText,
      filteredUserList: filteredUserList ?? this.filteredUserList,
    );
  }

  @override
  bool operator ==(covariant UserListState other) {
    return other.status == status &&
        userList == other.userList &&
        filteredUserList == other.filteredUserList &&
        filterText == other.filterText;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      userList.hashCode ^
      filteredUserList.hashCode ^
      filterText.hashCode;
}
