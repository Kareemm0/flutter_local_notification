import 'package:flutter_local_notofication_application/local_notification_service.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  void resigetrTask() async {
    await Workmanager().registerPeriodicTask(
      "id1",
      "Show Simple Notification",
      frequency: Duration(seconds: 15),
    );
  }

  Future<void> init() async {
    await Workmanager().initialize(callbackDispatcher);

    resigetrTask();
  }

  void cancel(String id) {
    Workmanager().cancelByUniqueName(id);
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    LocalNotificationService.showNotification();
    return Future.value(true);
  });
}
