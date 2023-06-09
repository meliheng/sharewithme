import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
        await db
            .collection("appeals")
            .doc(appealEntity.email)
            .set(appealEntity.toMap());
        final storageRef = FirebaseStorage.instance
            .ref(appealEntity.email)
            .child("${appealEntity.email}_file");
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
      {required String email,
      required String password,
      required String username}) {
    return TaskEither.tryCatch(
      () async {
        var response = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        return UserEntity(
          email: email,
          followers: [],
          following: [],
          uid: response.user!.uid,
          username: username,
          about: "",
        );
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
  TaskEither<BaseFailure, UserEntity> signUpWithGoogle(
      {required String email,
      required String password,
      required String username}) {
    return TaskEither.tryCatch(
      () async {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        var user = await FirebaseAuth.instance.signInWithCredential(credential);
        return UserEntity(
          email: googleUser!.email,
          followers: [],
          following: [],
          uid: user.user!.uid,
          username: "dddd",
          about: "",
        );
      },
      (error, stackTrace) {
        print(error);
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
      var user =
          await db.collection('users').doc(response.user!.uid).get().then(
                (value) => UserEntity.fromFirestore(value),
              );
      return user;
    }, (error, stackTrace) {
      return AuthFailures.def();
    });
  }

  @override
  TaskEither<BaseFailure, Unit> logout() {
    return TaskEither.tryCatch(
      () async {
        var response = await auth.signOut();
        return unit;
      },
      (error, stackTrace) {
        return AuthFailures.def();
      },
    );
  }

  @override
  TaskEither<BaseFailure, bool> checkApply({required String email}) {
    return TaskEither.tryCatch(
      () async {
        var response = await db.collection("appeals").doc(email).get().then(
          (value) {
            return value.get("isApprovad");
          },
        );
        return response;
      },
      (error, stackTrace) => AuthFailures.def(),
    );
  }
}
