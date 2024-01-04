import 'package:firebase_auth/firebase_auth.dart';
import 'package:sharewithme/auth/auth_export.dart';

extension UserEntityX on UserEntity {
  String get totalFollowersString {
    return "${followers.length}";
  }

  String get totalFollowingString {
    return "${following.length}";
  }

  bool get isFollowing {
    if (followers.contains(FirebaseAuth.instance.currentUser!.email)) {
      return true;
    }
    return false;
  }

  bool get isFollower {
    if (following.contains(FirebaseAuth.instance.currentUser!.email)) {
      return true;
    }
    return false;
  }
}
