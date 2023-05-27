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
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: ListTile(
         
        leading: icon,
        title: Text(text),
        trailing: showSwitch
            ? Switch(
                value: false,
                activeColor: ColorConstants.primaryOrange,
                  
                onChanged: (value) {},
              )
            : null,
      onTap: onTap,
      ),
    );
  }
}
