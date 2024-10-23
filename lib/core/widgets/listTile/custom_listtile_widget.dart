import 'package:flutter/material.dart';
import 'package:plantist/core/constants/app_color.dart';

class CustomListTile extends StatelessWidget {
  final Color? containerColor;
  final IconData? icon;
  final String titleText;
  final Widget? contentText;
  final bool? value;
  final void Function(bool)? onChanged;
  final bool isBorder;
  final void Function()? onTap;
  final String? reminderText;
  final double? iconSize;

  const CustomListTile({
    super.key,
    this.containerColor,
    this.icon,
    required this.titleText,
    this.contentText,
    this.value,
    this.onChanged,
    required this.isBorder,
    this.onTap,
    this.reminderText,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(15.0);
    const borderColor = AppColor.grey;

    if (isBorder) {
      return Container(
        decoration: BoxDecoration(
          color: AppColor.greyLight,
          borderRadius: borderRadius,
          border: Border.all(color: borderColor),
        ),
        child: ListTile(
          title: Text(
            titleText,
            style: const TextStyle(fontSize: 16, color: AppColor.secondary),
          ),
          subtitle: contentText,
          trailing: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            children: [
              Text(reminderText ?? '', style: const TextStyle(color: AppColor.greyDark)),
              Icon(icon, color: AppColor.greyDark, size: iconSize ?? 18),
            ],
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          onTap: onTap,
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: borderRadius,
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColor.white),
          ),
          title: Text(titleText, style: const TextStyle(fontSize: 16)),
          subtitle: contentText,
          trailing: value != null
              ? Switch.adaptive(
                  value: value!,
                  onChanged: onChanged,
                )
              : const SizedBox.shrink(),
        ),
      );
    }
  }
}
