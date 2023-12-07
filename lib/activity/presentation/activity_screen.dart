import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sharewithme/activity/application/_application_exporter.dart';
import 'package:sharewithme/activity/presentation/widgets/activity_card.dart';
import 'package:sharewithme/export.dart';

class ActivityScreen extends StatefulWidget {
  final AuthCubit authCubit;
  static const route = '/activity';
  const ActivityScreen({super.key, required this.authCubit});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final ActivityListCubit cubit = ActivityListCubit.instance();
  @override
  void initState() {
    cubit.getActivities(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("activities").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return ActivityCard(
                cubit: cubit,
                activityEntity: ActivityEntity.fromFirestore(
                  snapshot.data!.docs[index],
                ),
              );
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
