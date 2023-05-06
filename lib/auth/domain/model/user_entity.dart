import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  final String email;
  final String uid;
  final List followers;

  UserEntity(this.email, this.uid, this.followers);
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'uid': uid,
      'followers': followers,
    };
  }

  factory UserEntity.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return UserEntity(
      data?['email'],
      data?['uid'],
      data?['followers'],
    );
  }
}
