import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/user/presentation/profile/setting_list_tile.dart';

class ProfileScreen extends StatefulWidget {
  final AuthCubit authCubit;
  static const route = '/profile';
  const ProfileScreen({super.key, required this.authCubit});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String image = "";
  @override
  void initState() {
    super.initState();
    FirebaseStorage.instance
        .ref(widget.authCubit.state.user!.email)
        .child("${widget.authCubit.state.user!.uid}_avatar")
        .getDownloadURL()
        .then((value) {
      print(value);
      image = value;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: widget.authCubit,
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          color: ColorConstants.primaryOrange,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.primaryWhite,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "widget.authCubit.state.user!.email,",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            const Text(
                              "Marmara University",
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SettingListTile(
                              icon: Icon(Icons.notification_add),
                              text: "Bildirimler",
                              showSwitch: true,
                              onTap: null,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SettingListTile(
                              icon: const FaIcon(
                                  FontAwesomeIcons.arrowRightFromBracket),
                              text: "Çıkış Yap",
                              showSwitch: false,
                              onTap: () async {
                                //print(cubit.state.user!.email);
                                await widget.authCubit.logout(context);
                                // ignore: use_build_context_synchronously
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return const WelcomeScreen();
                                  },
                                ), (route) => false);
                                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                //   return const WelcomeScreen();
                                // },),);
                                // setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    // final ImagePicker picker = ImagePicker();
                    // final XFile? image =
                    //     await picker.pickImage(source: ImageSource.gallery);
                    // if(image!=null){
                    // final storageRef = FirebaseStorage.instance
                    //     .ref(widget.authCubit.state.user!.email)
                    //     .child("${widget.authCubit.state.user!.uid}_avatar");
                    // await storageRef.putFile(File(image.path));

                    // }
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      image,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
