import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  //! 1 - Setup
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static onTab(NotificationResponse details) {}

  static Future<void> init() async {
    InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTab,
      onDidReceiveBackgroundNotificationResponse: onTab,
    );
  }

  //! 2 - Basic Notification
  static void showNotification() async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "id 1 ",
        "basic ",
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      "Notification Title",
      "Notification Body",
      details,
      payload: "Notification Payload",
    );
  }

  //! 3 - Repeated Notification

  static void reapeatedNotification() async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "id 1 ",
        "Repeated Notification ",
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    await flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      "Repeated Title",
      "Repeated Body",
      RepeatInterval.everyMinute,
      details,
      payload: "Notification Payload",
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  //! 4 - cancel Notification
  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  //! 5 - Scheduled Notification
}
