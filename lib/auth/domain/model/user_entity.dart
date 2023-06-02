import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  final String email;
  final String uid;
  final List followers;
  final List following;
  final String? about;
  final String username;

  UserEntity({
    required this.email,
    required this.uid,
    required this.followers,
    required this.following,
    this.about,
    required this.username,
  });

  factory UserEntity.def() {
    return UserEntity(
      email: "",
      uid: "",
      followers: [],
      following: [],
      username: "",
    );
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'uid': uid,
      'followers': followers,
      'following': following,
      'about': about,
      'username': username,
    };
  }

  factory UserEntity.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return UserEntity(
      email: data?['email'],
      uid: data?['uid'],
      followers: data?['followers'] ?? [],
      following: data?['following'] ?? [],
      about: data?['about'] ?? '',
      username: data?['username'] ?? '',
    );
  }

  String get totalFollowersString {
    return "${followers.length}";
  }

  String get totalFollowingString {
    return "${following.length}";
  }

  UserEntity copyWith({
    String? email,
    String? uid,
    List? followers,
    List? following,
    String? about,
    String? username,
  }) {
    return UserEntity(
      email: email ?? this.email,
      uid: uid ?? this.uid,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      about: about ?? this.about,
      username: username ?? this.username,
    );
  }
}
