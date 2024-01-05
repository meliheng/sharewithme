import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';

class CircularAvatarWithEditIcon extends StatefulWidget {
  final String? imagePath;
  final Function(File file)? onFileSelected;
  final double radius;
  const CircularAvatarWithEditIcon({
    Key? key,
    this.onFileSelected,
    this.imagePath,
    this.radius = 30,
  }) : super(key: key);

  @override
  State<CircularAvatarWithEditIcon> createState() =>
      _CircularAvatarWithEditIconState();
}

class _CircularAvatarWithEditIconState
    extends State<CircularAvatarWithEditIcon> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.imagePath != null && widget.imagePath!.isNotEmpty)
          CircleAvatar(
            radius: widget.radius,
            backgroundImage: NetworkImage(widget.imagePath!),
          )
        else
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(IconC.kUserProfileIcon),
                fit: BoxFit.cover,
              ),
            ),
          ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              TaskHelper<File>().executeTaskWithoutLoading(
                context: context,
                task: FileHelper.pickImage(),
                onRight: (f) {
                  widget.onFileSelected?.call(f);
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
