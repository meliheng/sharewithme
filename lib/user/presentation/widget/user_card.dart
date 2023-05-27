import 'package:flutter/material.dart';
import 'package:sharewithme/auth/auth_export.dart';
import 'package:sharewithme/user/application/user_list_cubit/user_list_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserCard extends StatefulWidget {
  final UserEntity userEntity;
  final UserListCubit cubit;
  const UserCard({super.key, required this.userEntity, required this.cubit});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            shape: const BeveledRectangleBorder(),
            child: ClipPath(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.greenAccent, width: 5),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.userEntity.email),
                        if (!widget.cubit
                            .isFollowed(userEntity: widget.userEntity))
                          IconButton(
                            icon: const Icon(
                              Icons.follow_the_signs_sharp,
                            ),
                            onPressed: () {
                              widget.cubit
                                  .addFollow(userEntity: widget.userEntity);
                              setState(() {});
                            },
                          )
                        else
                          const FaIcon(FontAwesomeIcons.faceKiss)
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              widget.userEntity.totalFollowersString,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              widget.userEntity.totalFollowingString,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
