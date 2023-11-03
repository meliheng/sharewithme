import 'package:flutter/material.dart';
import 'package:sharewithme/shared/_shared_exporter.dart';

void showErrorDialog({required BuildContext context, required String message}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.sizeOf(context).width * .7,
            height: MediaQuery.sizeOf(context).height * .2,
            color: ColorConstants.kBlue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(message),
                CustomButton(
                  title: "TAMAM",
                  color: ColorConstants.primaryOrange,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
