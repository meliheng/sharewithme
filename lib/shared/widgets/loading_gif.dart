import 'package:flutter/material.dart';
import 'package:sharewithme/shared/constants/image_constants.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image(
        image: AssetImage(ImageC.loadingGif),
      ),
    );
  }
}
