import 'package:flutter/material.dart';
import 'package:picspeak_front/auth/password.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        width: double.infinity,
        height: double.infinity,
        color: Color.fromARGB(255, 253, 235, 235), // Color de fondo
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Crear una nueva Cuenta',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
              Text(
                'Por favor introduce tu correo electrónico para comenzar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 50),
              TextField(
                obscureText: false,
                autofocus: false,
                style: TextStyle(
                    fontSize: 22.0, color: Color.fromARGB(255, 0, 0, 0)),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Correo Electronico',
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Password()),
                  );
                },
                child: Text(
                  'Continuar >',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(102, 213, 216, 1),
                  minimumSize: Size(250.0, 60.0),
                ),
              ),
              const SizedBox(height: 40),
              IconButton(
                onPressed: () {
                  // Acción cuando se presiona el botón de retroceso
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 40.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
