import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:plantist/core/constants/app_text.dart';
import 'package:plantist/core/themes/app_theme.dart';
import 'package:plantist/core/widgets/snackbar/show_snackbar.dart';
import 'package:plantist/data/local/hive_boxes.dart';
import 'package:plantist/data/repositories/auth_repository.dart';
import 'package:plantist/presentation/home/viewmodel/home_view_model.dart';

class SettingsViewModel extends GetxController {
  final AuthRepository _authRepository = AuthRepositoryImpl();
  final HomeViewModel viewModel = Get.put(HomeViewModel());

  RxBool isBiometricAuthenticated = false.obs;
  RxBool authenticated = false.obs;
  RxBool isDarkMode = false.obs;
  final LocalAuthentication localAuth = LocalAuthentication();

  SettingsViewModel() {
    _loadBiometricPreference();
    _loadDarkModePreference();
  }
  // Load dark mode preference from Hive
  void _loadDarkModePreference() {
    var box = Hive.box(HiveBoxes.settingsBox);
    bool darkMode = box.get('isDarkMode', defaultValue: false);
    isDarkMode.value = darkMode;
  }

  // Load biometric preference from Hive
  void _loadBiometricPreference() {
    var box = Hive.box(HiveBoxes.userBox);
    bool biometricEnabled = box.get('biometric_enabled', defaultValue: false);
    isBiometricAuthenticated.value = biometricEnabled;
  }

  Future<void> toggleBiometric(bool value) async {
    if (value) {
      try {
        bool canCheckBiometrics = await localAuth.canCheckBiometrics;
        bool isDeviceSupported = await localAuth.isDeviceSupported();

        if (canCheckBiometrics && isDeviceSupported) {
          bool didAuthenticate = await localAuth.authenticate(
              localizedReason: AppText.confirmAuth,
              options: const AuthenticationOptions(
                  useErrorDialogs: false,
                  stickyAuth: false,
                  sensitiveTransaction: false,
                  biometricOnly: false));

          if (didAuthenticate) {
            var box = Hive.box(HiveBoxes.userBox);
            await box.put('biometric_enabled', true);
            isBiometricAuthenticated.value = true;
            showSuccessSnackbar(message: AppText.biometricEnabled);
          } else {
            showErrorSnackbar(message: AppText.biometricFailed);
          }
        } else {
          showErrorSnackbar(message: AppText.biometricNotSupported);
        }
      } on PlatformException catch (e) {
        showErrorSnackbar(message: AppText.biometricError);
        if (kDebugMode) {
          print("PlatformException: ${e.message}");
        }
      }
    } else {
      var box = Hive.box(HiveBoxes.userBox);
      await box.put('biometric_enabled', false);
      isBiometricAuthenticated.value = false;
      showSuccessSnackbar(message: AppText.biometricDisabled);
    }
  }

  Future<void> signOut() async {
    var result = await _authRepository.signOut();
    if (!result.isSuccess) {
      showErrorSnackbar(message: AppText.signOutFailed);
      return;
    }
    var box = Hive.box(HiveBoxes.userBox);
    var settingsBox = Hive.box(HiveBoxes.settingsBox);
    await box.put('biometric_enabled', false);
    await box.put('isLoggedIn', false);
    await settingsBox.put('isDarkMode', false);
    await box.clear();
    Get.offAndToNamed('/welcome');
    viewModel.reminders.clear();
    viewModel.filteredReminders.clear();
    showSuccessSnackbar(message: AppText.signOutSuccess);
  }

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    Get.changeTheme(value ? AppTheme.darkTheme : AppTheme.lightTheme);

    final settingsBox = Hive.box(HiveBoxes.settingsBox);
    settingsBox.put('isDarkMode', value);
  }
}
