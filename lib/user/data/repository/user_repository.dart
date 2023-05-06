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
        print("repodayım");

        await db.collection("users").get().then(
          (querySnapshot) {
            for (var item in querySnapshot.docs) {
              users.add(UserEntity.fromFirestore(item));
            }
          },
        );
        return users;
      },
      (error, stackTrace) {
        print(error);
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
            .doc(userEntity.uid)
            .set(userEntity.toMap());

        return unit;
      },
      (error, stackTrace) {
        print(error);
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
            )
          },
        );

        return unit;
      },
      (error, stackTrace) {
        print(error);
        return AuthFailures.def();
      },
    );
  }
}