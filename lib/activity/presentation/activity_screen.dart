import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/activity/application/activity_cubit/activity_cubit.dart';
import 'package:sharewithme/export.dart';

class ActivityScreen extends StatefulWidget {
  final AuthCubit authCubit;
  static const route = '/activity';
  const ActivityScreen({super.key, required this.authCubit});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final ActivityCubit cubit = ActivityCubit.instance();
  @override
  void initState() {
    cubit.getActivities(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("---------------------------");
    print(widget.authCubit.state.user!.uid);
    return SingleChildScrollView(
      child: BlocConsumer<ActivityCubit, ActivityState>(
        bloc: cubit,
        listener: (context, state) {},
        builder: (context, state) {
          return state.status == ActivityStatus.submitting
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    cubit.getAllActivity(
                        userEntity: widget.authCubit.state.user!),
                    _buildAddActivityButton(context),
                  ],
                );
        },
      ),
    );
  }

  FloatingActionButton _buildAddActivityButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ColorConstants.primaryOrange,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AddActivityDialog(cubit: cubit);
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {},
            iconSize: 30,
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {},
            iconSize: 30,
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () {},
            iconSize: 30,
            icon: const Icon(Icons.settings),
          )
        ],
      ),
    );
  }
}
