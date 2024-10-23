import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';
import 'package:plantist/core/constants/app_text.dart';
import 'package:plantist/data/local/hive_boxes.dart';
import 'package:plantist/data/repositories/auth_repository.dart';

class SplashViewModel extends GetxController {
  late AnimationController splashAnimationController;
  RxBool isBiometricEnabled = false.obs;
  RxBool isBiometricAuthenticated = false.obs;
  final LocalAuthentication _localAuth = LocalAuthentication();
  final AuthRepository _authRepository = AuthRepositoryImpl();

  @override
  void onInit() {
    super.onInit();

    _navigateBasedOnUser();
  }

  Future<void> _navigateBasedOnUser() async {
    await Future.delayed(const Duration(seconds: 1));

    var box = Hive.box(HiveBoxes.userBox);
    bool isLoggedIn = box.get('isLoggedIn', defaultValue: false);
    bool isBiometricEnabled = box.get('biometric_enabled', defaultValue: false);
    var currentUser = _authRepository.getCurrentUser();
    if (currentUser.data == null) {
      Get.offAllNamed('/welcome');
      return;
    }
    if (isLoggedIn) {
      if (isBiometricEnabled) {
        await _authenticateUser();
      } else {
        _navigateToHome();
      }
    } else {
      Get.offAllNamed('/welcome');
    }
  }

  Future<void> _authenticateUser() async {
    try {
      bool authenticated = await _localAuth.authenticate(
        localizedReason: AppText.confirmAuth,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
          useErrorDialogs: true,
        ),
      );
      if (authenticated) {
        _navigateToHome();
      } else {
        _navigateToBiometric();
      }
    } on PlatformException {
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    Get.offAllNamed('/home');
  }

  void _navigateToBiometric() {
    Get.offAllNamed('/biometric');
  }
}
