import 'package:hive_flutter/hive_flutter.dart';

class HiveBoxes {
  static const String userBox = 'userBox';
  static const String settingsBox = 'settingsBox';

  static Future<void> initHive() async {
    await Hive.initFlutter();
    await Hive.openBox(HiveBoxes.userBox);
    await Hive.openBox(HiveBoxes.settingsBox);
  }
}
