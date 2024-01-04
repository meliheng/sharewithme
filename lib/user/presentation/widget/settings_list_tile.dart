import 'package:flutter/material.dart';
import 'package:sharewithme/shared/constants/style_constant.dart';

class SettingsListTile extends StatelessWidget {
  final String iconPath;
  final String title;
  const SettingsListTile({
    super.key,
    required this.iconPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(iconPath),
      title: Text(
        title,
        style: StyleConstant.kBlack16,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
