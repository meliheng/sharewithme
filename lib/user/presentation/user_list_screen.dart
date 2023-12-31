import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sharewithme/export.dart';
import 'package:sharewithme/user/application/user_list_cubit/user_list_cubit.dart';
import 'package:sharewithme/user/presentation/_presentation_exporter.dart';

class UserListScreen extends StatefulWidget {
  final NavigationBarCubit pageCubit;
  static const route = '/search';

  const UserListScreen({
    Key? key,
    required this.pageCubit,
  }) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final UserListCubit cubit = UserListCubit.instance();
  @override
  void initState() {
    super.initState();
    cubit.getUsers(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserListCubit, UserListState>(
      bloc: cubit,
      listener: (context, state) {},
      builder: (context, state) {
        return ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFieldWithIcon(
                hintText: "Search",
                icon: Icons.search,
                onChanged: cubit.filterTextChanged,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ..._buildList(),
          ],
        );
      },
    );
  }

  List<Widget> _buildList() {
    return cubit.state.filteredUserList
        .map(
          (e) => UserCard(
            userEntity: e,
            pageCubit: widget.pageCubit,
          ),
        )
        .toList();
  }
}
