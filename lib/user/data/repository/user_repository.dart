import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sharewithme/export.dart';
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
        await db.collection("users").doc(userEntity.email).update(
          {
            "followers": FieldValue.arrayUnion(
              [FirebaseAuth.instance.currentUser!.email],
            ),
          },
        );
        await db
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .update(
          {
            "following": FieldValue.arrayUnion(
              [userEntity.email],
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
        await db.collection("users").doc(userEntity.email).update(
          {
            "followers": FieldValue.arrayRemove(
              [FirebaseAuth.instance.currentUser!.email],
            ),
          },
        );
        await db
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .update(
          {
            "following": FieldValue.arrayRemove(
              [userEntity.email],
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

  @override
  TaskEither<BaseFailure, Unit> updateAvatar(
      {required UserEntity userEntity, required File file}) {
    return TaskEither.tryCatch(
      () async {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('/${userEntity.email}')
            .child('/avatar');
        var uploadTask = await storageRef.putFile(file);
        var downloadPath = await uploadTask.ref.getDownloadURL();

        await db
            .collection(CollectionConstant.kUsers)
            .doc(userEntity.email)
            .set(userEntity.copyWith(avatar: downloadPath).toMap());
        return unit;
      },
      (error, stackTrace) {
        return AuthFailures.def();
      },
    );
  }
}
