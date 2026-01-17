import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key, required this.response});

  final NotificationResponse response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notification Response "), centerTitle: true),
      body: Center(
        child: Text("${response.id!}:${response.payload ?? "Test"}"),
      ),
    );
  }
}
