import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sharewithme/export.dart';

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
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ColorConstants.grayV2.withOpacity(.4),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: widget.onTap,
            child: isLiked
                ? SvgPicture.asset(
                    ImageConstants.favoriteIcon,
                    color: Colors.red,
                  )
                : SvgPicture.asset(
                    ImageConstants.favoriteIcon,
                  ),
          ),
          const SizedBox(width: 10),
          Text(likeCount),
        ],
      ),
    );
  }
}
