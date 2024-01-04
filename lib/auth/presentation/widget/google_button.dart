import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/constants/style_constant.dart';

class GoogleButton extends StatelessWidget {
  final void Function()? onTap;
  const GoogleButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorConstant.kGrayV2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              IconC.kGoogleIcon,
              height: 20,
            ),
            const SizedBox(width: 20),
            Text(
              AuthStringConstants.loginWithGoogle,
              textAlign: TextAlign.center,
              style: StyleConstant.kBlack14W5,
            ),
          ],
        ),
      ),
    );
  }
}
