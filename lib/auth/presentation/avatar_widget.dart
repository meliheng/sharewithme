import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sharewithme/shared/helper/_shared_helper_exporter.dart';

class CircularAvatarWithEditIcon extends StatefulWidget {
  final String image;
  final Function(File file)? onFileSelected;
  const CircularAvatarWithEditIcon({
    Key? key,
    required this.image,
    this.onFileSelected,
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
        // Circular Avatar
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(
                widget.image,
              ), // Replace with your image URL
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Edit Icon in the top-right corner
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              TaskHelper<File>().executeTaskWithoutError(
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
