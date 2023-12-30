import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sharewithme/activity/domain/model/activity_entity.dart';
import 'package:sharewithme/activity/domain/repository/i_activity_repository.dart';
import 'package:sharewithme/shared/failures/auth_failures.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';
import 'package:uuid/uuid.dart';

class ActivityRepository extends IActivityRepository {
  final db = FirebaseFirestore.instance;

  @override
  TaskEither<BaseFailure, Unit> add({
    required ActivityEntity activityEntity,
    required File file,
  }) {
    return TaskEither.tryCatch(
      () async {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('/${FirebaseAuth.instance.currentUser!.email}')
            .child('/postimage_${const Uuid().v1()}');
        var uploadTask = await storageRef.putFile(file);
        var downloadPath = await uploadTask.ref.getDownloadURL();

        await db
            .collection("activities")
            .doc()
            .set(activityEntity.copyWith(imagePath: downloadPath).toMap());
        return unit;
      },
      (error, stackTrace) {
        return AuthFailures.def();
      },
    );
  }

  @override
  TaskEither<BaseFailure, List<ActivityEntity>> getAll() {
    return TaskEither.tryCatch(
      () async {
        List<ActivityEntity> activities = [];
        await db.collection("activities").get().then(
          (querySnapshot) {
            for (var item in querySnapshot.docs) {
              activities.add(ActivityEntity.fromFirestore(item));
            }
          },
        );
        return activities;
      },
      (error, stackTrace) {
        return AuthFailures.def();
      },
    );
  }

  @override
  TaskEither<BaseFailure, Unit> addComplaint(
      {required ActivityEntity activityEntity}) {
    return TaskEither.tryCatch(
      () async {
        await db.collection('complaints').doc(activityEntity.id).set(
          {
            "id": activityEntity.id,
            "count": FieldValue.increment(1),
          },
          SetOptions(merge: true),
        );
        return unit;
      },
      (error, stackTrace) {
        return AuthFailures.def();
      },
    );
  }

  @override
  TaskEither<BaseFailure, Unit> like(
      {required String id, required String userId}) {
    return TaskEither.tryCatch(
      () async {
        DocumentReference ref =
            FirebaseFirestore.instance.collection('activities').doc(id);
        ref.update(
          {
            'likes': FieldValue.arrayUnion(
              [userId],
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
}
