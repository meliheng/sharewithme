import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sharewithme/export.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../application/_application_exporter.dart';

class ActivityCard extends StatefulWidget {
  final ActivityListCubit cubit;
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
      elevation: 2,
      
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
            _actionRow(),
          ],
        ),
      ),
    );
  }

  Container _actionRow() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Row(
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
            onPressed: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: ActivityDetailScreen(
                  activityEntity: widget.activityEntity,
                  userEntity: widget.userEntity,
                ),
              );
            },
            icon: const Icon(
              Icons.comment_outlined,
              color: Colors.blue,
              fill: 1,
            ),
          ),
        ],
      ),
    );
  }

  Row _imageRow() {
    return Row(
      children: [
        Expanded(
          child: CachedNetworkImage(
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
