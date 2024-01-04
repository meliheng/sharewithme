import 'package:flutter/material.dart';
import 'package:sharewithme/shared/_shared_exporter.dart';
import 'package:sharewithme/shared/constants/style_constant.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onTap;
  const CustomSearchBar({
    super.key,
    required this.searchController,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SearchBar(
        trailing: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.mic,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              onTap(searchController.text);
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
        shape: MaterialStatePropertyAll(
          ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(ColorConstant.kPrimaryBlue),
        hintText: 'Search',
        hintStyle: MaterialStateProperty.all(StyleContant.kWhite12),
        textStyle: MaterialStateProperty.all(StyleContant.kWhite12),
        controller: searchController,
        onChanged: (value) {},
        onTap: () {},
      ),
    );
  }
}
