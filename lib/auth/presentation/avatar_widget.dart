import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';

class CircularAvatarWithEditIcon extends StatefulWidget {
  final File file;
  final Function(File file)? onFileSelected;
  const CircularAvatarWithEditIcon({
    Key? key,
    this.onFileSelected,
    required this.file,
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
        if (widget.file.path.isNotEmpty)
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: FileImage(widget.file),
                fit: BoxFit.cover,
              ),
            ),
          )
        else
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(ImageC.userProfileIcon),
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
