import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:plantist/core/enum/loading_status.dart';
import 'package:plantist/core/extension/string/string_extension.dart';
import 'package:plantist/data/local/hive_boxes.dart';
import 'package:plantist/data/repositories/auth_repository.dart';
import 'package:plantist/routes/app_routes.dart';

class SignUpViewModel extends GetxController {
  // Dependencies and controllers
  final AuthRepository _authRepository = AuthRepositoryImpl();

  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> passwordController = TextEditingController().obs;

  final Rx<FocusNode> emailNode = FocusNode().obs;
  final Rx<FocusNode> passwordNode = FocusNode().obs;

  // UI state
  RxString errorMessage = ''.obs;
  RxBool passwordVisible = true.obs;
  RxBool emailCheckVisible = false.obs;
  RxBool isButtonEnabled = false.obs;

  void checkSignable() {
    final email = emailController.value.text.trim();
    final password = passwordController.value.text.trim();

    final emailValid = email.isNotEmpty && email.isValidEmail();
    final passwordValid = password.isNotEmpty;
    isButtonEnabled.value = emailValid && passwordValid;
  }
  
  final signupStatus = LoadingStatus.initial.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Sign up function
  void signUp() async {
    if (!formKey.currentState!.validate()) return;

    String email = emailController.value.text.trim();
    String password = passwordController.value.text.trim();

    signupStatus.value = LoadingStatus.loading;

    var signUp = await _authRepository.signUp(
      email: email,
      password: password,
    );
    if (signUp.isSuccess) {
      var box = Hive.box(HiveBoxes.userBox);
      await box.put('isLoggedIn', true);
      signupStatus.value = LoadingStatus.success;
      Get.offAllNamed(AppRoutes.home);
    } else {
      errorMessage.value = signUp.error.toString();
      signupStatus.value = LoadingStatus.failure;
    }
  }

  // Cleanup
  @override
  void onClose() {
    emailController.value.dispose();
    passwordController.value.dispose();
    super.onClose();
  }
}
