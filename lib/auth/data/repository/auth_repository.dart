import 'dart:io';

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
        if (error is FirebaseAuthException) {
          print(error.message);
        }
        return AuthFailures.def();
      },
    );
  }

  // TaskEither<AuthFailures, Unit> checkUserIsExists({
  //   required String email,
  // }) {
  //   return TaskEither.tryCatch(
  //     () async {
  //       var response = await db.collection('users').doc();
  //     },
  //     (error, stackTrace) {},
  //   );
  // }

  @override
  TaskEither<BaseFailure, UserEntity> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
  }) {
    return TaskEither.tryCatch(
      () async {
        var response = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

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
          switch (error.code) {
            case 'email-already-in-use':
              return AuthFailures('Email address $email already in use.');
            case 'invalid-email':
              return AuthFailures('Email address $email is invalid.');
            case 'operation-not-allowed':
              return AuthFailures('Error during sign up.');
            case 'weak-password':
              return AuthFailures(
                  'Password is not strong enough. Add additional characters including special characters and numbers.');
            default:
              break;
          }
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
        if (error is FirebaseAuthException) {}
        return AuthFailures.def();
      },
    );
  }

  TaskEither<BaseFailure, Unit> checkUserIsExists({required String email}) {
    return TaskEither(
      () async {
        var response = await auth.fetchSignInMethodsForEmail(email);
        if (response.isEmpty) {
          print("if left girdi");
          return Either.left(
            AuthFailures("Böyle bir kullanıcı bulunamadı."),
          );
        }
        return Either.right(unit);
      },
    );
  }

  @override
  TaskEither<BaseFailure, UserEntity> signIn(
      {required String email, required String password}) {
    return checkUserIsExists(email: email).flatMap(
      (r) => TaskEither.tryCatch(
        () async {
          await auth.fetchSignInMethodsForEmail(email);
          var response = await auth.signInWithEmailAndPassword(
              email: email, password: password);
          var user =
              await db.collection('users').doc(response.user!.uid).get().then(
                    (value) => UserEntity.fromFirestore(value),
                  );
          return user;
        },
        (error, stackTrace) {
          return AuthFailures.def();
        },
      ),
    );
  }

  @override
  TaskEither<BaseFailure, Unit> logout() {
    return TaskEither.tryCatch(
      () async {
        var _ = await auth.signOut();
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

  @override
  TaskEither<BaseFailure, bool> validateEmail({required String email}) {
    return TaskEither(
      () async {
        return await db.collection("appeals").doc(email).get().then(
          (value) {
            if (value.exists) {
              return Either.left(
                AuthFailures(
                  "Bu maile kayıtlı bir başvuru zaten bulunmaktadır.",
                ),
              );
            } else {
              return Either.right(true);
            }
          },
        );
      },
    );
  }

  @override
  TaskEither<BaseFailure, String> addProfileImage({
    required String email,
    required File file,
  }) {
    return TaskEither.tryCatch(
      () async {
        if (file.path.isNotEmpty) {
          final storageRef =
              FirebaseStorage.instance.ref(email).child("profile_image");
          var uploadTask = await storageRef.putFile(file);
          var downloadPath = await uploadTask.ref.getDownloadURL();

          await db.collection("users").doc(email).set({'avatar': downloadPath});
          return downloadPath;
        } else {
          return '';
        }
      },
      (error, stackTrace) {
        return AuthFailures.def();
      },
    );
  }
}
