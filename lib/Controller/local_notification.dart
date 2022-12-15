import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class localnotificatio extends GetxController {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings("@mipmap/ic_launcher");

    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        requestCriticalPermission: true);

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin
        .initialize(initializationSettings);
  }

  Future<void> showbuttonmethod() async {
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('default_notification_channel_id', 'ShopStop',
        enableVibration: true,
        priority: Priority.max,
        importance: Importance.max,
        sound: RawResourceAndroidNotificationSound('msg'),
        playSound: true);
    DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin.show(0, "Congratulations",
        "Your Product Has Been Addes", notificationDetails);
  }
}

