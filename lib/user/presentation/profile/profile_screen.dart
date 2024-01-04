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

class _ProfileScreenState extends State<ProfileScreen> {
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
            Row(
              children: [
                Expanded(
                  child: CustomButton.withRadius(
                    title: StringC.kSettings,
                    color: ColorConstant.kGrayV1,
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: CustomButton.withRadius(
                    title: StringC.kActivities,
                    color: ColorConstant.kPrimaryBlue,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            CustomContainer(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    SettingsListTile(
                      iconPath: IconC.kChangePasswordIcon,
                      title: StringC.kChangePassword,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: CustomDivider(),
                    ),
                    SettingsListTile(
                      iconPath: IconC.kNotificationIcon,
                      title: StringC.kNotification,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: CustomDivider(),
                    ),
                    SettingsListTile(
                      iconPath: IconC.kChangePasswordIcon,
                      title: StringC.kChangePassword,
                    ),
                  ],
                ),
              ),
            ),
          ],
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
