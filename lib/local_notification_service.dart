import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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

    //! Request Permission for Android 13+
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  //! 2 - Basic Notification
  static void showNotification() async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "id1",
        "basic",
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
        "id1",
        "Repeated Notification",
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
  static void scheduledNotification() async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "id3",
        "Scheduled Notification",
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    tz.initializeTimeZones();
    final TimezoneInfo timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName.identifier));
    await flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      "Scheduled Title",
      "Scheduled Body",
      //tz.TZDateTime(tz.local, 2026, 1, 7, 19, 26),
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
      details,
      payload: "Notification Payload",
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }
}
