import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/constants/style_constant.dart';

class LikeButton extends StatefulWidget {
  final Function()? onTap;
  final List<String> likes;
  const LikeButton({
    super.key,
    this.onTap,
    required this.likes,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool get isLiked =>
      widget.likes.contains(FirebaseAuth.instance.currentUser!.uid);
  String get likeCount => widget.likes.length.toString();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child: isLiked
              ? SvgPicture.asset(
                  IconC.kLikeIcon,
                  colorFilter:
                      const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                )
              : SvgPicture.asset(
                  IconC.kFavoriteIcon,
                ),
        ),
        const SizedBox(width: 10),
        Text(
          likeCount,
          style: StyleConstant.kBlackBold16,
        ),
      ],
    );
  }
}
