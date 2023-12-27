import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {

    // 初始化本地通知插件
    AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('avatar1');
    // DarwinInitializationSettings initializationSettingsIOS =  DarwinInitializationSettings(
    //   requestAlertPermission: true,
    //   requestBadgePermission: true,
    //   requestSoundPermission: true,
    //   onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) {}
    // );
    InitializationSettings initializationSettings = InitializationSettings
      (android: initializationSettingsAndroid);

    await notificationPlugin.initialize(initializationSettings);
  }

  // notificationsDetails() {
  //   return NotificationDetails(
  //     android: AndroidNotificationDetails('channelId', 'ChannelName'),
      
  //   )
  // }
}
