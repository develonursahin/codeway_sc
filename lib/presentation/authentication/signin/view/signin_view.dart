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
import '../viewmodel/signin_view_model.dart';

class SignInView extends StatelessWidget {
  final SignInViewModel viewModel = Get.put(SignInViewModel());

  SignInView({super.key});

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
            // Information widget
            const AuthInfoWidget(title: AppText.signinWithEmail),

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
            ),

            // Forgot password link
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: TextButton(
                onPressed: () {},
                child: const Text(AppText.forgotPassword),
              ),
            ),

            const SizedBox(height: 20),

            // Sign in button and loading dialog
            Obx(() {
              if (viewModel.signinStatus.value == LoadingStatus.loading) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showLoadingDialog(context);
                });
                return const SizedBox.shrink();
              } else {
                if (viewModel.signinStatus.value == LoadingStatus.success ||
                    viewModel.signinStatus.value == LoadingStatus.failure) {
                  Get.back();
                }
                return CustomElevatedButton(
                  onPressed: viewModel.signIn,
                  title: AppText.signIn,
                  textStyle: AppTextStyle.primaryBold18,
                  color: viewModel.isButtonEnabled.value ? AppColor.secondary : AppColor.grey,
                );
              }
            }),

            // Error message display
            Obx(() {
              return Text(
                viewModel.errorMessage.value,
                style: AppTextStyle.redHotRegular14,
              ).pOnly(top: 16);
            }),

            // Terms and privacy information
            const TermsAndPrivacyRichtextWidget(),
          ],
        ).pAll(16),
      ),
    );
  }
}
