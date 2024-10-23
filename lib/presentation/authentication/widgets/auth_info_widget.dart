import 'package:flutter/material.dart';
import 'package:plantist/core/constants/app_text.dart';
import 'package:plantist/core/constants/app_text_style.dart';

class AuthInfoWidget extends StatelessWidget {
  final String title;
  const AuthInfoWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.secondaryBold28,
          ),
          Text(
            AppText.enterYourEmailAndPassword,
            style: AppTextStyle.greyDarkRegular16,
          ),
        ],
      ),
    );
  }
}
