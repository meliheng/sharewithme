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
          CircleAvatar(
            radius: widget.radius,
            backgroundColor: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(widget.radius),
              ),
              child: Image.asset(
                IconC.kUserIcon,
              ),
            ),
          ),
        if (widget.onFileSelected != null)
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
                decoration: BoxDecoration(
                  color: ColorConstant.kPrimaryBlue,
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
