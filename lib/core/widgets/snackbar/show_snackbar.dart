import 'package:get/get.dart';
import 'package:plantist/core/constants/app_color.dart';
import 'package:plantist/core/constants/app_text.dart';

showSuccessSnackbar({required String message}) => Get.snackbar(
      AppText.success,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColor.secondary,
      colorText: AppColor.primary,
      duration: const Duration(seconds: 3),
    );

showErrorSnackbar({required String message}) => Get.snackbar(
      AppText.error,
      message,
      snackPosition: SnackPosition.TOP,
      borderColor: AppColor.redHot,
      borderWidth: 1,
      backgroundColor: AppColor.primary,
      colorText: AppColor.secondary,
      duration: const Duration(seconds: 3),
    );
