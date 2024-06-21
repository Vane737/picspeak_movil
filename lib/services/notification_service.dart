import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await notificationPlugin.initialize(initializationSettings);
  }

  notificationsDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'ChannelName',
          channelDescription: 'channel_description',
          importance: Importance.max,
          priority: Priority.max,
          playSound: true),
    );
  }

  Future showNotification({String? title, required String message}) async {
    int id = title.hashCode ^ message.hashCode;
    return notificationPlugin.show(
        id, title, message, await notificationsDetails());
  }
}
