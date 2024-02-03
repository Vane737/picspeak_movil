// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:picspeak_front/services/notification_service.dart';
import 'package:picspeak_front/views/auth/loading_screen.dart';
import 'views/auth/register_screen.dart';
import 'views/auth/login_screen.dart';
import 'config/theme/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await NotificationService().initNotification();
  runApp(MyApp());
    // Inicializa el servicio de notificaciones
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '!PicSpeak',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ), 
      home: Loading(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://img.freepik.com/vector-premium/hola-caligrafia-vectorial-letras-manuales-frases-saludo-diferentes-idiomas-burbujas-habla_258190-1420.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, 
            children: [
              const Padding(
                padding: EdgeInsets.all(35.0),
                child: Center(
                  child: Text(
                    '¡PickSpeak!',
                    style: TextStyle(
                      fontSize: 40.0,
                      color: AppColors.textColor,
                      fontFamily: 'Roboto'
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(237, 134, 182, 1),
                        minimumSize: const Size(300.0, 60.0),
                      ),
                      child: const Text(
                        'CREAR CUENTA',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 91, 197, 246),
                        minimumSize: const Size(300.0, 50.0),
                      ),
                      child: const Text(
                        'INICIAR SESION',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
