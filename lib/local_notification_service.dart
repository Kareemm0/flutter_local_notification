import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  //! 1 - Setup
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {},
      onDidReceiveBackgroundNotificationResponse: (details) {},
    );
  }

  //! 2 - Basic Notification
  void showNotification() async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails("id 1 ", "basic "),
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      "Notification Title",
      "Notification Body",
      details,
    );
  }

  //! 3 - Repeated Notification
  //! 4 - Scheduled Notification
}
