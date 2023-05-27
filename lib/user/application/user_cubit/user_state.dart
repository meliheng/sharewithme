// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sharewithme/auth/auth_export.dart';

enum UserStateStatus { initial, submitting, success, error }

class UserState {
  final UserStateStatus status;
  final UserEntity userEntity;
  UserState({
    required this.status,
    required this.userEntity,
  });

  factory UserState.initial() {
    return UserState(
      status: UserStateStatus.initial,
      userEntity: UserEntity.def(),
    );
  }

  UserState copyWith({
    UserStateStatus? status,
    UserEntity? userEntity,
  }) {
    return UserState(
      status: status ?? this.status,
      userEntity: userEntity ?? this.userEntity,
    );
  }

  @override
  bool operator ==(covariant UserState other) {
    if (identical(this, other)) return true;

    return other.status == status && other.userEntity == userEntity;
  }

  @override
  int get hashCode => status.hashCode ^ userEntity.hashCode;

  @override
  String toString() => 'UserState(status: $status, userEntity: $userEntity)';
}
