import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  final String email;
  final String uid;
  final List followers;
  final List following;
  final String? about;
  final String username;
  final String? avatar;

  UserEntity({
    required this.email,
    required this.uid,
    required this.followers,
    required this.following,
    this.about,
    required this.username,
    this.avatar,
  });

  factory UserEntity.def() {
    return UserEntity(
      email: "",
      uid: "",
      followers: [],
      following: [],
      username: "",
      avatar: "",
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
      'avatar': avatar,
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
      avatar: data?['avatar'],
    );
  }

  UserEntity copyWith({
    String? email,
    String? uid,
    List? followers,
    List? following,
    String? about,
    String? username,
    String? avatar,
  }) {
    return UserEntity(
      email: email ?? this.email,
      uid: uid ?? this.uid,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      about: about ?? this.about,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
    );
  }
}
