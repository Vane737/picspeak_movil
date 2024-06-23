import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationPlugin.initialize(initializationSettings);
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'messages', // channelId
      'Messages', // channelName
      channelDescription: 'Notifications for new messages', // channelDescription
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      ticker: 'ticker',
    );

    return const NotificationDetails(android: androidPlatformChannelSpecifics);
  }

  Future<void> showNotification({String? title, required String message}) async {
    // Generar un ID único basado en un timestamp
    final int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    // Crear la notificación
    await _notificationPlugin.show(
      id,
      title,
      message,
      await _notificationDetails(),
    );
  }
}
