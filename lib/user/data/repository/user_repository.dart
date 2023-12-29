import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sharewithme/shared/failures/auth_failures.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';
import 'package:sharewithme/auth/domain/model/user_entity.dart';
import 'package:sharewithme/user/domain/repository/i_user_repository.dart';

class UserRepository extends IUserRepository {
  final db = FirebaseFirestore.instance;
  @override
  TaskEither<BaseFailure, List<UserEntity>> getAll() {
    return TaskEither.tryCatch(
      () async {
        List<UserEntity> users = [];

        await db.collection("users").get().then(
          (querySnapshot) {
            for (var item in querySnapshot.docs) {
              users.add(UserEntity.fromFirestore(item));
            }
          },
        );
        return users
            .filter((t) => t.uid != FirebaseAuth.instance.currentUser!.uid)
            .toList();
      },
      (error, stackTrace) {
        return AuthFailures.def();
      },
    );
  }

  @override
  TaskEither<BaseFailure, Unit> add({required UserEntity userEntity}) {
    return TaskEither.tryCatch(
      () async {
        await db
            .collection("users")
            .doc(userEntity.email)
            .set(userEntity.toMap());

        return unit;
      },
      (error, stackTrace) {
        return AuthFailures.def();
      },
    );
  }

  @override
  TaskEither<BaseFailure, Unit> follow({required UserEntity userEntity}) {
    return TaskEither.tryCatch(
      () async {
        await db.collection("users").doc(userEntity.uid).update(
          {
            "followers": FieldValue.arrayUnion(
              [FirebaseAuth.instance.currentUser!.uid],
            ),
          },
        );
        await db
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(
          {
            "following": FieldValue.arrayUnion(
              [userEntity.uid],
            ),
          },
        );

        return unit;
      },
      (error, stackTrace) {
        return AuthFailures.def();
      },
    );
  }

  @override
  TaskEither<BaseFailure, Unit> unFollow({required UserEntity userEntity}) {
    return TaskEither.tryCatch(
      () async {
        await db.collection("users").doc(userEntity.uid).update(
          {
            "followers": FieldValue.arrayRemove(
              [FirebaseAuth.instance.currentUser!.uid],
            ),
          },
        );
        await db
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(
          {
            "following": FieldValue.arrayRemove(
              [userEntity.uid],
            ),
          },
        );

        return unit;
      },
      (error, stackTrace) {
        return AuthFailures.def();
      },
    );
  }

  @override
  TaskEither<BaseFailure, UserEntity> getById(String id) {
    return TaskEither.tryCatch(
      () async {
        return db.collection("users").doc(id).get().then(
          (value) {
            return UserEntity.fromFirestore(value);
          },
        );
      },
      (error, stackTrace) {
        return AuthFailures.def();
      },
    );
  }
}
