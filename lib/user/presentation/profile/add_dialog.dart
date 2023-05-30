import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';

class AddDialog extends StatelessWidget {
  final String title;
  final String hintText;
  final String buttonText;
  final void Function()? onPressed;
  final void Function(String)? onChanged;
  final String initialText;
  final Widget? extraWidget;
  const AddDialog({
    super.key,
    required this.title,
    required this.hintText,
    required this.buttonText,
    this.onPressed,
    this.onChanged,
    required this.initialText,
    this.extraWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      elevation: 15,
      insetPadding: const EdgeInsets.all(20),
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              color: ColorConstants.primaryOrange,
              alignment: Alignment.center,
              child: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            TextFieldWithIcon2(
              hintText: hintText,
              icon: Icons.abc,
              onChanged: onChanged,
              initialValue: initialText,
            ),
            if (extraWidget != null) extraWidget!,
            CustomButton(
              title: buttonText,
              color: ColorConstants.primaryOrange,
              onPressed: onPressed,
            )
          ],
        ),
      ),
    );
  }
}
