import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  final String email;
  final String uid;
  final List followers;
  final List following;

  UserEntity(
    this.email,
    this.uid,
    this.followers,
    this.following,
  );
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'uid': uid,
      'followers': followers,
      'following': following,
    };
  }

  factory UserEntity.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return UserEntity(
      data?['email'],
      data?['uid'],
      data?['followers']?? [],
      data?['following']??[],
    );
  }

  String  get totalFollowersString {
    return "${followers.length} Followers";
  }
  String get totalFollowingString {
    return "${following.length} Following";
  }
}
