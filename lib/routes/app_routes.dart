import 'package:get/get.dart';
import 'package:plantist/presentation/authentication/biometric/biometric_view.dart';
import 'package:plantist/presentation/authentication/signin/view/signin_view.dart';
import 'package:plantist/presentation/authentication/signup/view/signup_view.dart';
import 'package:plantist/presentation/home/view/home_view.dart';
import 'package:plantist/presentation/settings/view/settings_view.dart';
import 'package:plantist/presentation/splash/view/splash_view.dart';
import 'package:plantist/presentation/welcome/welcome_view.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String welcome = '/welcome';
  static const String settings = '/settings';
  static const String biometric = '/biometric';
  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => SplashView(),
    ),
    GetPage(
      name: home,
      page: () => HomeView(),
    ),
    GetPage(
      name: signin,
      page: () => SignInView(),
    ),
    GetPage(
      name: signup,
      page: () => SignUpView(),
    ),
    GetPage(
      name: welcome,
      page: () => const WelcomeView(),
    ),
    GetPage(
      name: settings,
      page: () => SettingsView(),
    ),
      GetPage(
      name: biometric,
      page: () => const BiometricView(),
    ),
  ];
}
