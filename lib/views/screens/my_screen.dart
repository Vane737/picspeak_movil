import 'package:flutter/material.dart';
import 'package:picspeak_front/services/notification_service.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}


class _MyScreenState extends State<MyScreen> {
  late final NotificationService notificationService;
  @override
  void initState() {
    notificationService = NotificationService();
    notificationService.initNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Acciones al presionar el botón
            print('Botón presionado');
            notificationService.showNotification(id: 0, title: 'Esta es una notificacion generada', message: 'Hola mundo');
          },
          child: Text('Presionar'),
        ),
      ),
    );
  }
}
