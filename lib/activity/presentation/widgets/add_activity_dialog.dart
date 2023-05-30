import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';

import '../../application/_application_exporter.dart';

class AddActivityDialog extends StatefulWidget {
  const AddActivityDialog({
    super.key,
    required this.cubit,
  });

  final ActivityCubit cubit;

  @override
  State<AddActivityDialog> createState() => _AddActivityDialogState();
}

class _AddActivityDialogState extends State<AddActivityDialog> {
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
              child: const Text(
                "Yeni Paylaşım",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextFieldWithIcon2(
              hintText: "içerik",
              icon: Icons.abc,
              onChanged: (p0) {
                widget.cubit.contentChanged(p0);
              },
            ),
            IconButton(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();
                if (result != null) {
                  File file = File(result.files.first.path ?? '');
                  if (!mounted) {
                    return;
                  }
                  widget.cubit.imageSelected(file);
                }
              },
              icon: Icon(
                Icons.image,
                color: ColorConstants.primaryOrange,
              ),
            ),
            CustomButton(
              title: "Paylaş",
              color: ColorConstants.primaryOrange,
              onPressed: () {
                widget.cubit.addActivity(context);
                widget.cubit.getActivities(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
