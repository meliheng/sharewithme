import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sharewithme/activity/application/activity_cubit/activity_cubit.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/user/application/user_cubit/user_cubit.dart';
import 'package:sharewithme/user/presentation/profile/add_dialog.dart';
import 'package:sharewithme/user/presentation/profile/setting_list_tile.dart';

import '../../application/user_cubit/user_state.dart';

class ProfileScreen extends StatefulWidget {
  final AuthCubit authCubit;
  static const route = '/profile';
  const ProfileScreen({super.key, required this.authCubit});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String image = "";
  late UserCubit userCubit;
  @override
  void initState() {
    super.initState();
    // FirebaseStorage.instance
    //     .ref(widget.authCubit.state.user!.email)
    //     .child("${widget.authCubit.state.user!.uid}_avatar")
    //     .getDownloadURL()
    //     .then((value) {
    //   image = value;
    // });
    // print("init");
    // print(widget.authCubit.state.user!.uid);
    userCubit = UserCubit.instance(userEntity: widget.authCubit.state.user!);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      bloc: userCubit,
      listener: (context, state) {},
      builder: (context, state) {
        return ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Column(
                children: [
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
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg"),
                    ),
                  ),
                  Text(
                    widget.authCubit.state.user!.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
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
                    icon: const FaIcon(FontAwesomeIcons.arrowRightFromBracket),
                    text: "Çıkış Yap",
                    showSwitch: false,
                    onTap: () async {
                      //print(cubit.state.user!.email);
                      await widget.authCubit.logout(context);
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WelcomeScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _followersCard(),
                  _aboutMeCard(context),
                  context.read<ActivityCubit>().getAllActivity(
                      userEntity: userCubit.state.userEntity, onlyOwn: true),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Row _followersCard() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              userCubit.userEntity.totalFollowersString,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              userCubit.userEntity.totalFollowingString,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  ExpansionTileCard _aboutMeCard(BuildContext context) {
    return ExpansionTileCard(
      title: const Text("Hakkımda"),
      children: [
        const Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              userCubit.state.userEntity.about!,
            ),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.spaceAround,
          buttonHeight: 52,
          buttonMinWidth: 90,
          children: [
            if (userCubit.state.userEntity.about!.isEmpty)
              _addButton(context)
            else
              _editButton(),
          ],
        )
      ],
    );
  }

  TextButton _editButton() {
    return TextButton(
      style: TextButton.styleFrom(
        iconColor: ColorConstants.primaryOrange,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AddDialog(
            buttonText: "DÜZENLE",
            hintText: "Kendin hakkında birşeyler yaz",
            title: "Hakkımda Ekle",
            initialText: userCubit.state.userEntity.about!,
            onChanged: userCubit.onAboutChanged,
            onPressed: () {
              userCubit.addAbout(context);
            },
          ),
        );
      },
      child: const Column(
        children: [
          Icon(Icons.edit),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
          ),
          Text("Düzenle")
        ],
      ),
    );
  }

  TextButton _addButton(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          iconColor: ColorConstants.primaryOrange,
          textStyle: const TextStyle(color: Colors.black)),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AddDialog(
            buttonText: "EKLE",
            hintText: "Kendin hakkında birşeyler yaz",
            title: "Hakkımda Ekle",
            initialText: "",
            onChanged: userCubit.onAboutChanged,
            onPressed: () {
              userCubit.addAbout(context);
            },
          ),
        ).then((value) => setState(() {}));
      },
      child: const Column(
        children: [
          Icon(Icons.add),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
          ),
          Text("Ekle")
        ],
      ),
    );
  }
}
