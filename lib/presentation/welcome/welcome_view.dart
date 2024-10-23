import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantist/core/assets/assets.dart';
import 'package:plantist/core/constants/app_color.dart';
import 'package:plantist/core/constants/app_text.dart';
import 'package:plantist/core/constants/app_text_style.dart';
import 'package:plantist/core/extension/context/context_extension.dart';
import 'package:plantist/core/extension/string/string_extension.dart';
import 'package:plantist/core/extension/widget/widget_extension.dart';
import 'package:plantist/core/widgets/button/custom_elevated_button.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.instance.image.splash.toImage,
            const SizedBox(height: 20),
            Text(
              AppText.welcomeBack,
              style: AppTextStyle.secondaryRegular28,
            ),
            Text(
              AppText.appName,
              style: AppTextStyle.secondaryBold28,
            ),
            Text(
              AppText.appSlogan,
              style: AppTextStyle.greyDarkRegular18,
            ),
            CustomElevatedButton(
              onPressed: () {
                Get.toNamed('/signin');
              },
              title: AppText.signinWithEmail,
              color: AppColor.greyLight,
              textStyle: AppTextStyle.secondaryBold18,
              icon: const Icon(
                CupertinoIcons.mail_solid,
                color: AppColor.secondary,
              ),
            ).pSymmetric(vertical: context.pageHorizontal),
            RichText(
              text: TextSpan(
                style: AppTextStyle.greyDarkRegular16,
                children: [
                  TextSpan(
                    text: AppText.dontYouHaveAnAccount,
                    style: AppTextStyle.greyDarkRegular16,
                  ),
                  TextSpan(
                    text: AppText.signup,
                    style: AppTextStyle.secondaryBold16,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.toNamed('/signup');
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
