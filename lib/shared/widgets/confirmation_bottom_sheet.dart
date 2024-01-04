import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/constants/style_constant.dart';

class ConfirmationBottomSheet extends StatelessWidget {
  final VoidCallback onCancel, onOk;
  const ConfirmationBottomSheet({
    super.key,
    required this.onCancel,
    required this.onOk,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            StringC.kAreYouSureToUnFollowFromFriends,
            style: StyleConstant.kBlackBold16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomButton(
                  title: StringC.kCancel,
                  color: Colors.red,
                  onPressed: onCancel,
                ),
              ),
              Expanded(
                child: CustomButton(
                  title: StringC.kYes,
                  color: ColorConstant.kPrimaryBlue,
                  onPressed: onOk,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
