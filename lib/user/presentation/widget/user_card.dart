import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/home/navigation_bar_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sharewithme/user/application/search_cubit/search_cubit.dart';
import 'package:sharewithme/user/application/search_cubit/search_state.dart';

class UserCard extends StatefulWidget {
  final UserEntity userEntity;

  final NavigationBarCubit pageCubit;
  const UserCard({
    super.key,
    required this.userEntity,
    required this.pageCubit,
  });

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  late SearchCubit searchCubit;
  @override
  void initState() {
    super.initState();
    searchCubit = SearchCubit.instance(userEntity: widget.userEntity);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              // widget.pageCubit.updateShowing(false);
              // PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
              //   settings: const RouteSettings(name: "/prodsdfile"),
              //   context,
              //   screen: UserDetailScreen(userEntity: widget.userEntity),
              //   withNavBar: true,
              //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
              // );
            },
            child: Card(
              shape: const BeveledRectangleBorder(),
              child: ClipPath(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: ColorConstants.primaryOrange,
                        width: 5,
                      ),
                    ),
                  ),
                  child: BlocConsumer<SearchCubit, SearchState>(
                    bloc: searchCubit,
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.userEntity.email),
                              if (!searchCubit.isFollowed())
                                IconButton(
                                  icon: const FaIcon(
                                      FontAwesomeIcons.personCirclePlus),
                                  onPressed: () {
                                    searchCubit.onFollowButtonClicked(
                                      userId: FirebaseAuth
                                          .instance.currentUser!.uid,
                                    );
                                    searchCubit.addFollow(
                                      userEntity: widget.userEntity,
                                    );
                                    setState(() {});
                                  },
                                )
                              else
                                IconButton(
                                  icon: const FaIcon(
                                      FontAwesomeIcons.personCircleCheck),
                                  onPressed: () {
                                    searchCubit.onUnFollowButtonClicked(
                                      userId: FirebaseAuth
                                          .instance.currentUser!.uid,
                                    );
                                    searchCubit.unFollow(
                                      userEntity: widget.userEntity,
                                    );
                                    setState(() {});
                                  },
                                ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.greenAccent,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        widget.userEntity.totalFollowersString,
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                      const Text(
                                        "Takipçi",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
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
                                    horizontal: 15,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        widget.userEntity.totalFollowingString,
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                      const Text(
                                        "Takip",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(
                                flex: 2,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
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
