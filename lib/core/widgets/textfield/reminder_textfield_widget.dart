import 'package:flutter/material.dart';
import 'package:plantist/core/constants/app_color.dart';
import 'package:plantist/core/constants/app_text_style.dart';

class ReminderTextField extends StatelessWidget {
  final String hintText;
  final int maxLines;
  final int minLines;
  final Color? color;
  final bool? enabled;
  final TextEditingController? controller;
  final TextStyle? hintStyle;
  final FocusNode? node;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const ReminderTextField({
    super.key,
    required this.hintText,
    required this.maxLines,
    required this.minLines,
    this.enabled = true,
    this.color,
    this.controller,
    this.node,
    this.onChanged,
    this.hintStyle,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: node,
      maxLines: maxLines,
      minLines: minLines,
      enabled: enabled ?? false,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        errorStyle: AppTextStyle.redHotBold16,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.transparent),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.transparent),
        ),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.transparent),
        ),
        hintText: hintText,
        hintStyle: hintStyle ??
            TextStyle(
              letterSpacing: -0.6,
              color: color,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
