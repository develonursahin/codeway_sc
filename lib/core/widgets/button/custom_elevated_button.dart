import 'package:flutter/material.dart';
import 'package:plantist/core/constants/app_color.dart';
import 'package:plantist/core/extension/context/context_extension.dart';
import 'package:plantist/core/extension/widget/widget_extension.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final bool isFilled;
  final double? width;
  final double? height;
  final Color? color;
  final Color? borderColor;
  final Widget? icon;
  final TextStyle? textStyle;

  const CustomElevatedButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.isFilled = true,
      this.width,
      this.height,
      this.color,
      this.icon,
      this.textStyle,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
            onPressed: () async {
              if (onPressed != null) {
                onPressed!();
              }
            },
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(color ?? AppColor.secondary),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: context.border20Radius,
                    side: BorderSide(color: borderColor ?? color ?? AppColor.secondary))),
                elevation: const WidgetStatePropertyAll(0),
                foregroundColor: WidgetStatePropertyAll(color)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) icon!.pOnly(right: context.heighVal) else const SizedBox.shrink(),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: textStyle,
                ),
              ],
            ))
        .pSymmetric(horizontal: context.pageHorizontal)
        .sized(width: width ?? context.width, height: height ?? context.height * 0.08);
  }
}
