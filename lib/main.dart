import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:plantist/data/services/notification/local_notification_service.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest.dart' as tz;

import 'package:plantist/core/themes/app_theme.dart';
import 'package:plantist/data/local/hive_boxes.dart';

import 'firebase_options.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationHelper.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  tz.initializeTimeZones();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await HiveBoxes.initHive();
  final settingsBox = Hive.box(HiveBoxes.settingsBox);
  bool isDarkMode = settingsBox.get('isDarkMode', defaultValue: false) as bool;
  runApp(PlantistApp(isDarkMode: isDarkMode));
}

class PlantistApp extends StatelessWidget {
  final bool isDarkMode;
  const PlantistApp({super.key, this.isDarkMode = false});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plantist',
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
      theme: isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
    );
  }
}
