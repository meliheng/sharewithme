import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sharewithme/export.dart';

class CustomNavigationBar extends StatefulWidget {
  final NavigationBarCubit cubit;
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
                  widget.cubit.onPageChanged(0);
                },
                child: SvgPicture.asset(
                  IconC.kHomeIcon,
                  color: widget.cubit.iconColor(0),
                  height: 30,
                ),
              ),
            ),
            AnimatedNavigationButton(
              onTap: () {
                widget.cubit.onPageChanged(1);
              },
              icon: SvgPicture.asset(
                IconC.kSearchIcon,
                color: widget.cubit.iconColor(1),
                height: 30,
              ),
            ),
            // Material(
            //   child: InkWell(
            //     onTap: () {
            //       widget.cubit.onPageChanged(2);
            //     },
            //     child: SvgPicture.asset(
            //       IconC.kFavoriteIcon,
            //       color: widget.cubit.iconColor(2),
            //       height: 30,
            //     ),
            //   ),
            // ),
            Material(
              child: InkWell(
                onTap: () {
                  // FirebaseAuth.instance.signOut();
                  widget.cubit.onPageChanged(2);
                },
                child: SvgPicture.asset(
                  IconC.kProfileIcon,
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
