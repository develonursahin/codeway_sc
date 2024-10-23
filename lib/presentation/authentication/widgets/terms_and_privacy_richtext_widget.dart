import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantist/core/constants/app_text.dart';
import 'package:plantist/core/constants/app_text_style.dart';
import 'package:plantist/core/extension/context/context_extension.dart';
import 'package:plantist/core/extension/widget/widget_extension.dart';
import 'package:plantist/presentation/webview/web_view.dart';

class TermsAndPrivacyRichtextWidget extends StatelessWidget {
  const TermsAndPrivacyRichtextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppTextStyle.greyDarkRegular16.copyWith(letterSpacing: -0.6),
        children: [
          _buildTextSpan(AppText.privacyPolicyAndTermsOfUse),
          _buildInteractiveTextSpan(AppText.privacyPolicy),
          _buildTextSpan(AppText.and),
          _buildInteractiveTextSpan("${AppText.termsOfUse}."),
        ],
      ),
    ).pSymmetric(vertical: context.pageHorizontal);
  }

  // Helper method to create a standard text span
  TextSpan _buildTextSpan(String text) {
    return TextSpan(text: text, style: AppTextStyle.greyDarkRegular16);
  }

  // Helper method to create an interactive text span
  TextSpan _buildInteractiveTextSpan(String text) {
    return TextSpan(
      text: text,
      style: AppTextStyle.secondaryBold16.copyWith(
        decoration: TextDecoration.underline,
      ),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          Get.put(WebView(url: AppText.appUrl));
        },
    );
  }
}
