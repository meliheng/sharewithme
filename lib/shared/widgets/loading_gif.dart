import 'package:flutter/material.dart';
import 'package:sharewithme/shared/constants/image_constants.dart';

class LoadingGif extends StatelessWidget {
  const LoadingGif({super.key});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(ImageC.loadingGif),
    );
  }
}
