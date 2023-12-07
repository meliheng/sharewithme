import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sharewithme/export.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../application/_application_exporter.dart';

class ActivityCard extends StatefulWidget {
  final ActivityListCubit cubit;
  final ActivityEntity activityEntity;
  const ActivityCard({
    super.key,
    required this.cubit,
    required this.activityEntity,
  });

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  ActivityEntity get m => widget.activityEntity;
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
                    Text(
                      "Melihcan Yıldız",
                      style: TextStyle(
                        color: Colors.white,
                      ),
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
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ColorConstants.grayV2.withOpacity(.4),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        ImageConstants.favoriteIcon,
                      ),
                      const SizedBox(width: 10),
                      const Text("5.2k")
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Slidable _slidableCard() {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              CoolAlert.show(
                context: context,
                type: CoolAlertType.error,
                cancelBtnText: "İptal",
                confirmBtnText: "Sil",
                title: "Opsss...",
                showCancelBtn: true,
                confirmBtnColor: ColorConstants.primaryOrange,
                text: 'Silmek istediğine emin misin?',
                onConfirmBtnTap: () {
                  widget.cubit
                      .deleteActivity(activityEntity: widget.activityEntity);
                },
              );
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: _buildNormalCard(),
    );
  }

  Card _buildNormalCard() {
    return Card(
      elevation: 2,
      color: ColorConstants.kBlue,
      surfaceTintColor: Colors.blue,
      shape: ContinuousRectangleBorder(
        side: BorderSide(
          width: 1,
          color: ColorConstants.kBlue,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _firstRow(),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _contentRow(),
            ),
            if (widget.activityEntity.imagePath.isNotEmpty) _imageRow(),
            // _actionRow(),
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

  Row _imageRow() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(
              fit: BoxFit.fitWidth,
              height: 300,
              progressIndicatorBuilder: (context, url, progress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              imageUrl: widget.activityEntity.imagePath,
            ),
          ),
        ),
      ],
    );
  }

  Row _contentRow() {
    return Row(
      children: [
        Expanded(
          child: Text(widget.activityEntity.content),
        ),
      ],
    );
  }

  Row _firstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white),
            child: Text(widget.activityEntity.username),
          ),
        ),
        Expanded(
          child: Text(
            DateFormat.yMMMMEEEEd().format(widget.activityEntity.date),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Slidable _buildCard() {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              CoolAlert.show(
                context: context,
                type: CoolAlertType.error,
                cancelBtnText: "İptal",
                confirmBtnText: "Şikayet Et",
                title: "Emin misin?",
                showCancelBtn: true,
                confirmBtnColor: ColorConstants.primaryOrange,
                text: 'Şikayet etmek istediğine emin misin?',
                onConfirmBtnTap: () {
                  widget.cubit.addComplaint(
                    activityEntity: widget.activityEntity,
                    context: context,
                  );
                },
              );
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: FontAwesomeIcons.xmark,
            label: 'Şikayet Et',
          ),
        ],
      ),
      child: _buildNormalCard(),
    );
  }
}
