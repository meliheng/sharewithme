import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';

class CustomDivider extends StatelessWidget {
  final String? content;
  const CustomDivider({
    super.key,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: ColorConstants.grayV2,
            thickness: 2,
          ),
        ),
        if (content != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(content!),
          ),
        Expanded(
          child: Divider(
            color: ColorConstants.grayV2,
            thickness: 2,
          ),
        ),
      ],
    );
  }
}
