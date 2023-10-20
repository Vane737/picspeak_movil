import 'package:flutter/material.dart';
import 'auth/login.dart';
import 'auth/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '!PicSpeak',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Image.asset(
              'imagenes/first.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                '!PickSPEAK',
                style: TextStyle(
                  fontSize: 40.0,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Text(
                      'CREAR CUENTA',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(237, 134, 182, 1),
                      minimumSize: Size(300.0, 60.0),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: Text(
                      'INICIAR SESION',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 91, 197, 246),
                      minimumSize: Size(300.0, 50.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
