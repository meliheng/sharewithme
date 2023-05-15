import 'package:flutter/material.dart';
import 'package:sharewithme/auth/auth_export.dart';
import 'package:sharewithme/user/application/user_list_cubit/user_list_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserCard extends StatelessWidget {
  final UserEntity userEntity;
  final UserListCubit cubit;
  const UserCard({super.key, required this.userEntity, required this.cubit});

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
                        Text(userEntity.email),
                        if (!cubit.isFollowed(userEntity: userEntity))
                          IconButton(
                            icon: const Icon(
                              Icons.follow_the_signs_sharp,
                            ),
                            onPressed: () {
                              cubit.addFollow(userEntity: userEntity);
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
                            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text("15 Followers",style: TextStyle(fontSize: 12),),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text("5 Following",style: TextStyle(fontSize: 12)),
                          ),
                        ),
                        Spacer(flex: 2,),
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
