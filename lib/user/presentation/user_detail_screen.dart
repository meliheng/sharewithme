import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/export.dart';

import '../../activity/application/_application_exporter.dart';

class UserDetailScreen extends StatefulWidget {
  final UserEntity userEntity;
  const UserDetailScreen({super.key, required this.userEntity});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Column(
              children: [
                InkWell(
                  onTap: () async {},
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg"),
                  ),
                ),
                Text(
                  widget.userEntity.username,
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
                _followersCard(),
                _aboutMeCard(context),
                context.read<ActivityListCubit>().getAllActivity(
                    userEntity: widget.userEntity, onlyOwn: true),
              ],
            ),
          ),
        ],
      ),
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
              widget.userEntity.totalFollowersString,
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
              widget.userEntity.totalFollowingString,
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
              widget.userEntity.about!,
            ),
          ),
        ),
      ],
    );
  }
}
