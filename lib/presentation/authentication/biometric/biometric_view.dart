import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantist/core/constants/app_text.dart';
import 'package:plantist/core/constants/app_text_style.dart';
import 'package:plantist/core/extension/widget/widget_extension.dart';
import 'package:plantist/core/widgets/button/custom_elevated_button.dart';

class BiometricView extends StatelessWidget {
  const BiometricView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              AppText.biometricAuthFailed,
              style: AppTextStyle.blackBold20,
              textAlign: TextAlign.center,
            ).pAll(16),
            const SizedBox(height: 20),
            CustomElevatedButton(
                onPressed: () {
                  Get.offAllNamed('/welcome');
                },
                title: AppText.signOut),
            const SizedBox(height: 20),
            CustomElevatedButton(
                onPressed: () {
                  Get.offAllNamed('/splash');
                },
                title: AppText.tryAgain),
          ],
        ).pAll(16),
      ),
    );
  }
}
