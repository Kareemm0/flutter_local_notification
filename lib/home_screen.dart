import 'package:flutter/material.dart';
import 'package:flutter_local_notofication_application/local_notification_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home Screen'),
        leading: Icon(Icons.notifications),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //! 1- Basic Notification Button
            ListTile(
              onTap: () {
                LocalNotificationService.showNotification();
              },
              title: Text('Basic Notification'),
              leading: Icon(Icons.notifications),
              trailing: IconButton(
                onPressed: () {
                  LocalNotificationService.cancelNotification(0);
                },
                icon: Icon(Icons.cancel, color: Colors.red),
              ),
            ),
            //! 2- Repeated Notification Button
            ListTile(
              onTap: () {
                LocalNotificationService.reapeatedNotification();
              },
              title: Text('Repeated Notification'),
              leading: Icon(Icons.notifications),
              trailing: IconButton(
                onPressed: () {
                  LocalNotificationService.cancelNotification(1);
                },
                icon: Icon(Icons.cancel, color: Colors.red),
              ),
            ),
            //! 3- Schedule Notification Button
            ListTile(
              onTap: () {
                LocalNotificationService.scheduledNotification();
              },
              title: Text('Scheduled Notification'),
              leading: Icon(Icons.notifications),
              trailing: IconButton(
                onPressed: () {
                  LocalNotificationService.cancelNotification(2);
                },
                icon: Icon(Icons.cancel, color: Colors.red),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                LocalNotificationService.flutterLocalNotificationsPlugin
                    .cancelAll();
              },
              child: Text("Cancel All "),
            ),
          ],
        ),
      ),
    );
  }
}
