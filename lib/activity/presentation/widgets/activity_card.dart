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
    cb = ActivityCubit(activityEntity: m);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image(
                    image: NetworkImage(m.imagePath),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    m.username,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    m.date.toStringFormat,
                                    style: TextStyle(
                                      color: ColorConstants.grayV1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            SvgPicture.asset(
                              ImageConstants.optionsIcon,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 30,
              color: ColorConstants.grayV1.withOpacity(0.5),
              width: double.infinity,
              child: LikeButton(
                likes: m.likes,
                onTap: cb.likeActivity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
