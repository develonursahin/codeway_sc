import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantist/core/constants/app_color.dart';
import 'package:plantist/core/constants/app_text_style.dart';
import 'package:plantist/core/extension/context/context_extension.dart';
import 'package:plantist/core/extension/widget/widget_extension.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final int? maxLength;
  final int? maxCount;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool? hasError;
  final bool? onTapOutside;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool? obscureText;
  final Function()? onTap;
  final Function()? onTapTextField;
  final bool? enabled;
  final bool? readOnly;
  final bool isBorder;
  final bool isFilled;
  final bool isEmail;
  final bool isDate;
  final Function(String)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final int maxLine;
  final int minLine;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.hasError = false,
    this.validator,
    this.maxLength,
    this.maxCount,
    this.onChanged,
    this.obscureText = false,
    this.onTap,
    this.enabled,
    this.isBorder = true,
    this.isFilled = false,
    this.isEmail = false,
    this.isDate = false,
    this.onFieldSubmitted,
    this.maxLine = 1,
    this.minLine = 1,
    this.errorText,
    this.readOnly,
    this.onTapOutside,
    this.onTapTextField,
    this.onEditingComplete,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly ?? false,
      onTap: widget.onTapTextField ?? () {},
      onTapOutside: (_) {
        if (widget.onTapOutside == false && widget.onTapOutside != null) {
        } else {
          widget.focusNode.unfocus();
        }
      },
      inputFormatters: [
        if (widget.isEmail == true) ...[FilteringTextInputFormatter.singleLineFormatter],
        if (widget.maxCount != null) LengthLimitingTextInputFormatter(widget.maxCount),
      ],
      obscureText: widget.obscureText ?? false,
      maxLength: widget.maxLength,
      controller: widget.controller,
      focusNode: widget.focusNode,
      enabled: widget.enabled ?? true,
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      keyboardType:
          widget.isEmail ? TextInputType.emailAddress : widget.keyboardType ?? TextInputType.text,
      style: widget.hasError == true ? AppTextStyle.redHotBold16 : AppTextStyle.secondaryBold16,
      cursorColor: widget.focusNode.hasFocus ? AppColor.redHot : AppColor.greyDark,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      obscuringCharacter: '*',
      maxLines: widget.maxLine,
      minLines: widget.minLine,
      decoration: InputDecoration(
        hintStyle: AppTextStyle.greyDarkBold16,
        errorText: widget.errorText == "" ? null : widget.errorText,
        errorStyle: AppTextStyle.redHotBold16,
        fillColor: AppColor.white,
        filled: true,
        hintText: widget.hintText,
        contentPadding: context.heighPadding,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon ?? const SizedBox.shrink(),
        focusedBorder: _buildBorder(color: AppColor.grey),
        disabledBorder: _buildBorder(color: AppColor.greyLight),
        enabledBorder: _buildBorder(color: AppColor.grey),
        errorBorder: _buildBorder(color: Colors.red),
        focusedErrorBorder: _buildBorder(color: AppColor.redHot),
      ),
    ).pOnly(bottom: context.heighVal);
  }

  UnderlineInputBorder _buildBorder({required Color color}) {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: color, width: 1.0),
    );
  }
}
