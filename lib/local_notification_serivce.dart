import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> intialize() async {
    DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestCriticalPermission: true,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings settings =
        InitializationSettings(iOS: iosInitializationSettings);

    await _localNotificationService.initialize(
      settings,
      onDidReceiveNotificationResponse: onSelectNotification,
    );
  }

  Future<NotificationDetails> _notificationDetails() async {
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();
    return NotificationDetails(iOS: darwinNotificationDetails);
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }
}

void onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) {
  print("ID $id");
}

void onSelectNotification(NotificationResponse details) {
  print("Payload $details");
}
