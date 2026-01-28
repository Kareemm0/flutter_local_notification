import 'dart:async';
import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  //! 1 - Setup
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();
  static onTab(NotificationResponse details) {
    // log(details.id!.toString());
    // log(details.payload!.toString());

    streamController.add(details);
  }

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
        sound: RawResourceAndroidNotificationSound(
          "sound.wav".split('.').first,
        ),
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
      payload: "Notification Payload Schedule",
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  //! 6 - Daily Notification
  static void dailyNotification() async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "id4",
        "Daily Notification",
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    var currentTime = tz.TZDateTime.now(tz.local);
    var scheduleTime = tz.TZDateTime(
      tz.local,
      currentTime.year,
      currentTime.month,
      currentTime.day,
      17,
    );

    if (scheduleTime.isBefore(currentTime)) {
      scheduleTime = scheduleTime.add(Duration(days: 1));
      log("$scheduleTime");
    }
    log("$scheduleTime");
    await flutterLocalNotificationsPlugin.zonedSchedule(
      3,
      "Daily Title",
      "Daily Body",
      scheduleTime,
      // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
      details,
      payload: "Notification Payload Schedule",
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }
}
