import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';

import '../../application/_application_exporter.dart';

class AddActivityDialog extends StatelessWidget {
  const AddActivityDialog({
    super.key,
    required this.cubit,
  });

  final ActivityCubit cubit;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      elevation: 15,
      insetPadding: EdgeInsets.all(20),
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
                cubit.contentChanged(p0);
              },
            ),
            CustomButton(
              title: "Paylaş",
              color: ColorConstants.primaryOrange,
              onPressed: () {
                cubit.addActivity(context);
                cubit.getActivities(context);
            
              },
            )
          ],
        ),
      ),
    );
  }
}