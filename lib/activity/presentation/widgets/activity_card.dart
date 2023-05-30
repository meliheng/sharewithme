import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sharewithme/export.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../application/_application_exporter.dart';

class ActivityCard extends StatefulWidget {
  final ActivityCubit cubit;
  final ActivityEntity activityEntity;
  final UserEntity userEntity;
  final bool isProfileScreen;
  const ActivityCard({
    super.key,
    required this.cubit,
    required this.activityEntity,
    required this.userEntity,
    required this.isProfileScreen,
  });

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            constraints: const BoxConstraints(minHeight: 100, maxHeight: 200),
            child: widget.isProfileScreen ? _slidableCard() : _buildCard(),
          ),
        ),
      ],
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                  ),
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
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Text(widget.activityEntity.content),
              ),
            ],
          ),
          if (widget.activityEntity.imagePath.isNotEmpty)
            Row(
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    height: 50,
                    fit: BoxFit.fitWidth,
                    progressIndicatorBuilder: (context, url, progress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    imageUrl: widget.activityEntity.imagePath,
                  ),
                ),
              ],
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!widget.activityEntity.likes.contains(widget.userEntity.uid))
                IconButton(
                  onPressed: () async {
                    await widget.cubit
                        .likeActivity(widget.activityEntity, widget.userEntity);
                  },
                  icon: const Icon(
                    Icons.favorite_outline,
                    color: Colors.pink,
                    fill: 1,
                  ),
                )
              else
                const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.pink,
                    fill: 1,
                  ),
                ),
              Text(widget.activityEntity.totalLikeString),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.comment_outlined,
                  color: Colors.blue,
                  fill: 1,
                ),
              ),
            ],
          ),
        ],
      ),
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
