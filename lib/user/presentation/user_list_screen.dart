import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/user/application/search_cubit/search_cubit.dart';
import 'package:sharewithme/user/presentation/_presentation_exporter.dart';

class UserListScreen extends StatefulWidget {
  static const route = '/search';

  const UserListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final SearchCubit cubit = SearchCubit();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        CustomSearchBar(
          searchController: cubit.searchController,
          onTap: (p0) {
            cubit.setFilterText();
            setState(() {});
          },
        ),
        StreamBuilder(
          stream: cubit.state.userCollection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LoadingDialog());
            }
            cubit.setDocuments(snapshot.data!.docs);
            cubit.filterDocuments();
            return Expanded(
              child: ListView.builder(
                itemCount: cubit.state.documents.length,
                itemBuilder: (context, index) {
                  return UserCard(
                    userEntity:
                        UserEntity.fromFirestore(cubit.state.documents[index]),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
