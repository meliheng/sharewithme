import 'package:flutter/material.dart';
import 'package:sharewithme/shared/_shared_exporter.dart';

class CustomDialog {
  static void success({
    required BuildContext context,
    required String message,
    VoidCallback? onSubmit,
  }) {
    showCustomDialog(
      context: context,
      message: message,
      isSuccess: true,
      onSubmit: onSubmit,
    );
  }

  static void error({
    required BuildContext context,
    required String message,
  }) {
    showCustomDialog(
      context: context,
      message: message,
      isSuccess: false,
    );
  }
}

void showCustomDialog({
  required BuildContext context,
  required String message,
  required bool isSuccess,
  VoidCallback? onSubmit,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: MediaQuery.sizeOf(context).width * .7,
            height: MediaQuery.sizeOf(context).height * .3,
            color: ColorConstant.kBlue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image(
                  image: isSuccess
                      ? AssetImage(IconC.kCheckIcon)
                      : AssetImage(IconC.kErrorIcon),
                  fit: BoxFit.cover,
                  height: MediaQuery.sizeOf(context).height * .1,
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        title: StringC.kClose,
                        color: ColorConstant.kPrimaryOrange,
                        onPressed: () {
                          Navigator.pop(context);
                          onSubmit?.call();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
