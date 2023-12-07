// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sharewithme/shared/constants/image_constants.dart';
import 'package:sharewithme/shared/home/page_cubit.dart';

class CustomNavigationBar extends StatefulWidget {
  final PageCubit cubit;
  const CustomNavigationBar({
    super.key,
    required this.cubit,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * .1,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.50),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              child: InkWell(
                onTap: () {
                  widget.cubit.changeIndex(0);
                },
                child: SvgPicture.asset(
                  ImageConstants.homeIcon,
                  color: widget.cubit.iconColor(0),
                  height: 30,
                ),
              ),
            ),
            Material(
              child: InkWell(
                onTap: () {
                  widget.cubit.changeIndex(1);
                },
                child: SvgPicture.asset(
                  ImageConstants.favoriteIcon,
                  color: widget.cubit.iconColor(1),
                  height: 30,
                ),
              ),
            ),
            Material(
              child: InkWell(
                onTap: () {
                  // widget.cubit.changeIndex(2);
                  FirebaseAuth.instance.signOut();
                },
                child: SvgPicture.asset(
                  ImageConstants.profileIcon,
                  color: widget.cubit.iconColor(2),
                  height: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
