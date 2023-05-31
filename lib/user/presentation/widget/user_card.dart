import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/home/page_cubit.dart';
import 'package:sharewithme/user/application/user_list_cubit/user_list_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sharewithme/user/presentation/_presentation_exporter.dart';

class UserCard extends StatefulWidget {
  final UserEntity userEntity;
  final UserListCubit cubit;
  final PageCubit pageCubit;
  const UserCard({
    super.key,
    required this.userEntity,
    required this.cubit,
    required this.pageCubit,
  });

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              widget.pageCubit.updateShowing(false);
              PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                settings: const RouteSettings(name: "/prodsdfile"),
                context,
                screen: UserDetailScreen(userEntity: widget.userEntity),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            child: Card(
              shape: const BeveledRectangleBorder(),
              child: ClipPath(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                          color: ColorConstants.primaryOrange, width: 5),
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
                                Icons.add,
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
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
                          const Spacer(
                            flex: 2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
