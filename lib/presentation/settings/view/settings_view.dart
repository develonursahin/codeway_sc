import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantist/core/constants/app_color.dart';
import 'package:plantist/core/constants/app_text.dart';
import 'package:plantist/core/widgets/dialog/show_loading_dialog.dart';
import 'package:plantist/presentation/settings/viewmodel/settings_viewmodel.dart';
import 'package:plantist/presentation/settings/widget/settings_listtile_widet.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  final SettingsViewModel _viewModel = Get.put(SettingsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SettingsListTileWidget(
            titleText: AppText.signOut,
            onTap: () async {
              showLoadingDialog(context);
              await _viewModel.signOut();
            },
            trailing: const Icon(Icons.logout_outlined, color: AppColor.grey),
          ),
          const Divider(),
          Obx(
            () => SettingsListTileWidget(
                titleText: AppText.biometricLock,
                onTap: () {},
                trailing: Switch.adaptive(
                  value: _viewModel.isBiometricAuthenticated.value,
                  onChanged: (value) {
                    _viewModel.toggleBiometric(value);
                  },
                )),
          ),
          const Divider(),
          Obx(
            () => SettingsListTileWidget(
                titleText: "Dark Mode",
                onTap: () {},
                trailing: Switch.adaptive(
                  value: _viewModel.isDarkMode.value,
                  onChanged: (value) {
                    _viewModel.toggleDarkMode(value);
                  },
                )),
          ),
        ],
      ),
    );
  }
}
