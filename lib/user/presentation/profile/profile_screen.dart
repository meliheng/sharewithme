import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sharewithme/auth/presentation/avatar_widget.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/constants/style_constant.dart';

class ProfileScreen extends StatefulWidget {
  static const route = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(CollectionConstant.kUsers)
          .doc(FirebaseAuth.instance.currentUser!.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState.isLoading) {
          return const Center(
            child: LoadingDialog(),
          );
        }
        final UserEntity user = UserEntity.fromFirestore(snapshot.data!);
        return Column(
          children: [
            const SizedBox(height: 20),
            CircularAvatarWithEditIcon(
              radius: 50,
              imagePath: user.avatar,
              onFileSelected: (file) {
                ProfileCubit cubit = ProfileCubit(userEntity: user);
                cubit.updateAvatar(file);
              },
            ),
            Text(
              user.username,
              style: StyleConstant.kBlackBold18,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.1,
                    blurRadius: 1,
                    offset: const Offset(1, 2),
                  ),
                ],
              ),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _infoBox(
                    count: '20',
                    title: StringC.kActivities,
                  ),
                  _infoBox(
                    count: user.followers.length.toString(),
                    title: StringC.kFollowers,
                  ),
                  _infoBox(
                    count: user.following.length.toString(),
                    title: StringC.kFollowing,
                  ),
                ],
              ),
            ),
            _activitiesTab(),
          ],
        );
      },
    );
  }

  Widget _activitiesTab() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(CollectionConstant.kActivities)
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState.isLoading) {
          return const Center(
            child: LoadingDialog(),
          );
        }
        final List<ActivityEntity> list = snapshot.data!.docs
            .map((e) => ActivityEntity.fromFirestore(e))
            .toList();
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 images per row
            crossAxisSpacing: 8.0, // spacing between columns
            mainAxisSpacing: 8.0, // spacing between rows
          ),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Image(
              image: NetworkImage(list[index].imagePath),
              fit: BoxFit.cover,
            );
          },
        );
      },
    );
  }

  Column _infoBox({
    required String count,
    required String title,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count,
          style: StyleConstant.kBlackBold18,
        ),
        Text(
          title,
          style: StyleConstant.kBlack14W5,
        ),
      ],
    );
  }
}
