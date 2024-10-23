import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantist/core/constants/app_color.dart';
import 'package:plantist/core/constants/app_text.dart';
import 'package:plantist/core/constants/app_text_style.dart';
import 'package:plantist/core/enum/loading_status.dart';
import 'package:plantist/core/extension/widget/widget_extension.dart';
import 'package:plantist/core/widgets/button/custom_elevated_button.dart';
import 'package:plantist/core/widgets/dialog/show_loading_dialog.dart';
import 'package:plantist/presentation/authentication/widgets/auth_form_widget.dart';
import 'package:plantist/presentation/authentication/widgets/auth_info_widget.dart';
import 'package:plantist/presentation/authentication/widgets/terms_and_privacy_richtext_widget.dart';
import '../viewmodel/signup_view_model.dart';

class SignUpView extends StatelessWidget {
  final SignUpViewModel viewModel = Get.put(SignUpViewModel());

  SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        iconTheme: const IconThemeData(color: AppColor.secondary),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Info widget
            const AuthInfoWidget(title: AppText.signupWithEmail),

            // Authentication form widget
            AuthFormWidget(
              formKey: viewModel.formKey,
              emailNode: viewModel.emailNode.value,
              emailController: viewModel.emailController.value,
              emailCheckVisible: viewModel.emailCheckVisible,
              passwordNode: viewModel.passwordNode.value,
              passwordController: viewModel.passwordController.value,
              passwordVisible: viewModel.passwordVisible,
              onSignableChanged: viewModel.checkSignable,
            ).pOnly(bottom: 20),

            // Sign up button and loading dialog
            Obx(() {
              if (viewModel.signupStatus.value == LoadingStatus.loading) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showLoadingDialog(context);
                });
                return const SizedBox.shrink();
              } else {
                if (viewModel.signupStatus.value == LoadingStatus.success ||
                    viewModel.signupStatus.value == LoadingStatus.failure) {
                  Get.back();
                }

                return CustomElevatedButton(
                  onPressed: viewModel.signUp,
                  title: AppText.createAccount,
                  color: viewModel.isButtonEnabled.value ? AppColor.secondary : AppColor.grey,
                  textStyle: AppTextStyle.primaryBold18,
                );
              }
            }),

            // Error message display
            Obx(() {
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  viewModel.errorMessage.value,
                  style: AppTextStyle.redHotRegular14,
                ),
              );
            }),

            // Terms and privacy information
            const TermsAndPrivacyRichtextWidget(),
          ],
        ).paddingAll(16),
      ),
    );
  }
}
