import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';

import 'package:sharewithme/auth/domain/repository/i_auth_repository.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/failures/auth_failures.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';

class AuthRepository extends IAuthRepository {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
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

  @override
  TaskEither<BaseFailure, UserEntity> signUpWithEmailAndPassword(
      {required String email, required String password}) {
    return TaskEither.tryCatch(
      () async {
        var response = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        return UserEntity(email, password);
      },
      (error, stackTrace) {
        if (error is FirebaseAuthException) {
          print(error);
        }
        return AuthFailures.def();
      },
    );
  }

  @override
  TaskEither<BaseFailure, UserEntity> signIn(
      {required String email, required String password}) {
    return TaskEither.tryCatch(() async {
      var response = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      var user = UserEntity(response.user!.email!, response.user!.uid);
      return user;
    }, (error, stackTrace) {
      print(error);
      return AuthFailures.def();
    });
  }
}
