// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sharewithme/auth/auth_export.dart';

enum SearchStateStatus { initial, submitting, success, error }

class SearchState {
  final SearchStateStatus status;
  final UserEntity userEntity;
  SearchState({
    required this.status,
    required this.userEntity,
  });

  factory SearchState.initial() {
    return SearchState(
      status: SearchStateStatus.initial,
      userEntity: UserEntity.def(),
    );
  }

  SearchState copyWith({
    SearchStateStatus? status,
    UserEntity? userEntity,
  }) {
    return SearchState(
      status: status ?? this.status,
      userEntity: userEntity ?? this.userEntity,
    );
  }

  @override
  bool operator ==(covariant SearchState other) {
    if (identical(this, other)) return true;

    return other.status == status && other.userEntity == userEntity;
  }

  @override
  int get hashCode => status.hashCode ^ userEntity.hashCode;

  @override
  String toString() => 'SearchState(status: $status, userEntity: $userEntity)';
}
