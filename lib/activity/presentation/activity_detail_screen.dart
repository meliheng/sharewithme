import 'package:flutter/material.dart';
import 'package:sharewithme/activity/domain/_domain_exporter.dart';
import 'package:sharewithme/activity/presentation/_presentation_exporter.dart';
import 'package:sharewithme/shared/theme/custom_app_bar.dart';

class ActivityDetailScreen extends StatefulWidget {
  final ActivityEntity activityEntity;
  // final UserEntity userEntity;

  const ActivityDetailScreen({
    super.key,
    required this.activityEntity,
    // required this.userEntity,
  });

  @override
  State<ActivityDetailScreen> createState() => _ActivityDetailScreenState();
}

class _ActivityDetailScreenState extends State<ActivityDetailScreen> {
  final TextEditingController commentController =
      TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar()),
      body: Column(
        children: [
          Center(
            child: ActivityCard(activityEntity: widget.activityEntity),
          ),
        ],
      ),
    );
  }
}
