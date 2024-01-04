import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';

class SettingListTile extends StatelessWidget {
  final Widget icon;
  final String text;
  final bool showSwitch;
  final void Function()? onTap;
  const SettingListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.showSwitch,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstant.kPrimaryOrange,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: ColorConstant.kPrimaryOrange),
      ),
      child: ListTile(
        leading: icon,
        iconColor: Colors.white,
        title: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: showSwitch
            ? Switch(
                value: false,
                activeColor: ColorConstant.kPrimaryOrange,
                onChanged: (value) {},
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
