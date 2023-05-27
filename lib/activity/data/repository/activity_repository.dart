import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sharewithme/activity/domain/model/activity_entity.dart';
import 'package:sharewithme/activity/domain/repository/i_activity_repository.dart';
import 'package:sharewithme/shared/failures/auth_failures.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';

class ActivityRepository extends IActivityRepository {
  final db = FirebaseFirestore.instance;

  @override
  TaskEither<BaseFailure, Unit> add({required ActivityEntity activityEntity}) {
    return TaskEither.tryCatch(
      () async {
        await db.collection("activities").doc().set(activityEntity.toMap());
        return unit;
      },
      (error, stackTrace) {
        print(error);
        return AuthFailures.def();
      },
    );
  }

  @override
  TaskEither<BaseFailure, List<ActivityEntity>> getAll() {
    return TaskEither.tryCatch(
      () async {
        List<ActivityEntity> activities = [];
        await db.collection("activities").snapshots();
        
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
}
