import 'dart:io';
import 'package:sharewithme/auth/domain/_domain_exporter.dart';
import 'package:sharewithme/shared/vo/name_vo.dart';

enum ApplyStatus { initial, submitting, success, error }

class ApplyState {
  final AppealEntity appealEntity;
  final ApplyStatus status;
  ApplyState({
    required this.status,
    required this.appealEntity,
  });
  factory ApplyState.initial() {
    return ApplyState(
      appealEntity: AppealEntity(
        fullname: Name.def(),
        school: Name.def(),
        department: Name.def(),
        email: "",
        file: File(""),
      ),
      status: ApplyStatus.initial,
    );
  }
  ApplyState copyWith({
    ApplyStatus? status,
    AppealEntity? appealEntity,
  }) {
    return ApplyState(
      status: status ?? this.status,
      appealEntity: appealEntity ?? this.appealEntity,
    );
  }

  @override
  bool operator ==(covariant ApplyState other) {
    return other.status == status && other.appealEntity == appealEntity;
  }

  @override
  int get hashCode {
    return appealEntity.hashCode ^ status.hashCode;
  }
}
