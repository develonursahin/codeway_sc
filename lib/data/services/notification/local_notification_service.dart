// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationHelper {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const androidInitialize = AndroidInitializationSettings('@mipmap/launcher_icon');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    const initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: initializationSettingsDarwin);
    _notifications.initialize(initializationsSettings);
  }

  static Future<NotificationDetails> _notificationsDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "daily",
        "counter",
        importance: Importance.max,
      ),
    );
  }

  static Future<void> showNotification({
    int id = 0,
    required String title,
    required String body,
    required String payload,
  }) async {
    _notifications.show(
      id,
      title,
      body,
      await _notificationsDetails(),
      payload: payload,
    );
  }

  static Future<void> scheduleRecurringNotifications({
    required DateTime startDate,
    required String title,
    required String body,
    required int id,
  }) async {
    _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(startDate, tz.local),
      await _notificationsDetails(),
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> unScheduleAllNotification() async {
    return await _notifications.cancelAll();
  }

  static Future<void> unScheduleNotification(int id) async {
    return await _notifications.cancel(id);
  }

  static Future<void> unScheduleAllNotifications(List<int> ids) async {
    for (int id in ids) {
      await _notifications.cancel(id);
    }
  }
}
