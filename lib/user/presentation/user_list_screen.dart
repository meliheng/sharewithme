import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/user/application/user_list_cubit/user_list_cubit.dart';
import 'package:sharewithme/user/presentation/_presentation_exporter.dart';

class UserListScreen extends StatefulWidget {
  static const route = '/search';

  const UserListScreen({super.key});

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
        return Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextFieldWithIcon(
              hintText: "Search",
              icon: Icons.search,
              onChanged: cubit.filterTextChanged,
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
          (e) => UserCard(userEntity: e, cubit: cubit),
        )
        .toList();
  }
}
