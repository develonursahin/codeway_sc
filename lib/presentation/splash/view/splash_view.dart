import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantist/core/assets/assets.dart';
import 'package:plantist/core/constants/app_color.dart';
import 'package:plantist/core/extension/string/string_extension.dart';
import 'package:plantist/presentation/splash/viewmodel/splash_view_model.dart';

class SplashView extends StatelessWidget {
  final SplashViewModel controller = Get.put(SplashViewModel());

  SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Assets.instance.image.splash.toImage,
      ),
    );
  }
}
