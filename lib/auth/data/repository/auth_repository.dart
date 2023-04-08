import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sharewithme/auth/domain/model/appeal_entity.dart';
import 'package:sharewithme/auth/domain/repository/i_auth_repository.dart';
import 'package:sharewithme/shared/failures/auth_failures.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';

class AuthRepository extends IAuthRepository {
  final db = FirebaseFirestore.instance;
  @override
  TaskEither<BaseFailure, Unit> apply({required AppealEntity appealEntity}) {
    return TaskEither.tryCatch(
      () async {
        await db.collection("appeals").doc().set(appealEntity.toMap());
        final storageRef =
            FirebaseStorage.instance.ref().child("files/${appealEntity.email}");
        await storageRef.putFile(appealEntity.file);
        return unit;
      },
      (error, stackTrace) {
        return AuthFailures.def();
      },
    );
  }
}
