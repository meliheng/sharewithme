import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sharewithme/export.dart';

class ActivityCard extends StatefulWidget {
  final ActivityEntity activityEntity;
  const ActivityCard({
    super.key,
    required this.activityEntity,
  });

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  ActivityEntity get m => widget.activityEntity;
  late ActivityCubit cb;
  @override
  void initState() {
    super.initState();
    print('activity card init');
    cb = ActivityCubit(activityEntity: m);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(m.imagePath),
          fit: BoxFit.cover,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TaskHelper<UserEntity>().futureBuilder(
                      context: context,
                      task: cb.userRepository.getById(m.userId),
                      onLeft: (_) {
                        return const Text(
                          '-',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        );
                      },
                      onRight: (s) {
                        return Text(
                          s.username,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                    Text(
                      m.date.toIso8601String(),
                      style: TextStyle(
                        color: ColorConstants.grayV1,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SvgPicture.asset(
                  ImageConstants.optionsIcon,
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LikeButton(
                  likes: m.likes,
                  onTap: cb.likeActivity,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Container _actionRow() {
  //   return Container(
  //     decoration: const BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.only(
  //         bottomLeft: Radius.circular(10),
  //         bottomRight: Radius.circular(10),
  //       ),
  //     ),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         if (!widget.activityEntity.likes.contains(widget.userEntity.uid))
  //           IconButton(
  //             onPressed: () async {
  //               await widget.cubit
  //                   .likeActivity(widget.activityEntity, widget.userEntity);
  //             },
  //             icon: const Icon(
  //               Icons.favorite_outline,
  //               color: Colors.pink,
  //               fill: 1,
  //             ),
  //           )
  //         else
  //           const IconButton(
  //             onPressed: null,
  //             icon: Icon(
  //               Icons.favorite,
  //               color: Colors.pink,
  //               fill: 1,
  //             ),
  //           ),
  //         Text(widget.activityEntity.totalLikeString),
  //         IconButton(
  //           onPressed: () {
  //             // PersistentNavBarNavigator.pushNewScreen(
  //             //   context,
  //             //   screen: ActivityDetailScreen(
  //             //     activityEntity: widget.activityEntity,
  //             //     userEntity: widget.userEntity,
  //             //   ),
  //             // );
  //           },
  //           icon: const Icon(
  //             Icons.comment_outlined,
  //             color: Colors.blue,
  //             fill: 1,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
