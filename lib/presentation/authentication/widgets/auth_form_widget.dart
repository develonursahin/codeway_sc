import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantist/core/constants/app_color.dart';
import 'package:plantist/core/constants/app_text.dart';
import 'package:plantist/core/extension/string/string_extension.dart';
import 'package:plantist/core/widgets/textfield/custom_text_field.dart';

class AuthFormWidget extends StatelessWidget {
  final FocusNode emailNode;
  final TextEditingController emailController;
  final RxBool emailCheckVisible;
  final FocusNode passwordNode;
  final TextEditingController passwordController;
  final RxBool passwordVisible;
  final GlobalKey<FormState> formKey;
  final VoidCallback onSignableChanged; // Add this line

  const AuthFormWidget({
    super.key,
    required this.emailNode,
    required this.emailController,
    required this.emailCheckVisible,
    required this.passwordNode,
    required this.passwordController,
    required this.passwordVisible,
    required this.formKey,
    required this.onSignableChanged, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // Email TextField
          Obx(() {
            return CustomTextField(
              focusNode: emailNode,
              controller: emailController,
              hintText: AppText.email,
              suffixIcon: emailCheckVisible.value
                  ? const Icon(Icons.check_circle_sharp, color: AppColor.secondary)
                  : const SizedBox.shrink(),
              onChanged: (value) {
                emailCheckVisible.value = value.isNotEmpty && value.emailValidate;
                onSignableChanged(); // Trigger the callback here
              },
              validator: (value) {
                return value!.isEmpty
                    ? AppText.pleaseEnterYourEmail
                    : !value.emailValidate
                        ? AppText.invalidEmail
                        : null;
              },
            );
          }),
          // Password TextField
          Obx(() {
            return CustomTextField(
              focusNode: passwordNode,
              controller: passwordController,
              hintText: AppText.password,
              obscureText: passwordVisible.value,
              validator: (value) {
                return value!.isEmpty ? AppText.pleaseEnterYourPassword : null;
              },
              onChanged: (value) {
                onSignableChanged(); // Trigger the callback here as well
              },
              suffixIcon: GestureDetector(
                onTap: () {
                  passwordVisible.value = !passwordVisible.value;
                },
                child: Icon(
                  passwordVisible.value ? Icons.visibility : Icons.visibility_off,
                  color: AppColor.greyDark,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
