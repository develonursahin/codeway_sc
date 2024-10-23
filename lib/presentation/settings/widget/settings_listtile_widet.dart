import 'package:flutter/material.dart';

class SettingsListTileWidget extends StatelessWidget {
  final String titleText;
  final void Function()? onTap;
  final Widget trailing;

  const SettingsListTileWidget({
    super.key,
    required this.titleText,
    required this.onTap,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(titleText),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
