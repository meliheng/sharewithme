import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sharewithme/auth/presentation/avatar_widget.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/constants/style_constant.dart';
import 'package:sharewithme/user/application/user_cubit/user_cubit.dart';

class ProfileScreen extends StatefulWidget {
  // final AuthCubit authCubit;
  static const route = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserCubit userCubit;
  @override
  void initState() {
    super.initState();
    // getAvatar();
    // userCubit = UserCubit.instance(userEntity: widget.authCubit.state.user!);
  }

  // void getAvatar() {
  //   FirebaseStorage.instance
  //       .ref(widget.authCubit.state.user!.email)
  //       .child("${widget.authCubit.state.user!.uid}_avatar")
  //       .getDownloadURL()
  //       .then(
  //     (value) {
  //       if (value.isNotEmpty) {
  //         setState(() {
  //           image = value;
  //         });
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        CircularAvatarWithEditIcon(
          file: File(''),
        ),
        const Text(
          'Melihcan',
          style: StyleConstant.kBlackBold18,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorConstant.kPrimaryBlue, width: 2),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: ColorConstant.kPrimaryBlue.withOpacity(0.5),
                spreadRadius: 0.1,
                blurRadius: 1,
                offset: const Offset(1, 2),
              ),
            ],
          ),
          height: 80,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '20',
                    style: StyleConstant.kBlackBold18,
                  ),
                  Text(
                    'Activities',
                    style: StyleConstant.kBlack14W5,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '370',
                    style: StyleConstant.kBlackBold18,
                  ),
                  Text(
                    'Followers',
                    style: StyleConstant.kBlack14W5,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '200',
                    style: StyleConstant.kBlackBold18,
                  ),
                  Text(
                    'Following',
                    style: StyleConstant.kBlack14W5,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
