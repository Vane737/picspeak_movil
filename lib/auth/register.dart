import 'package:flutter/material.dart';
import 'package:picspeak_front/auth/password.dart';
import 'package:picspeak_front/chat/ChatList.dart';

import 'package:picspeak_front/config/theme/app_colors.dart';
import 'package:picspeak_front/presentation/widgets/custom_button.dart';

class Register extends StatelessWidget {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 70.0),
                child: Text(
                  'Iniciar Sesion',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: AppColors.textColor,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              const Text(
                'Porfavor, ingresa los datos para iniciar sesion',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.textColor,
                  fontFamily: 'Inter',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                child: Column(children: [
                  TextField(
                    obscureText: false,
                    autofocus: false,
                    style: const TextStyle(
                        fontSize: 22.0, color: Color.fromARGB(255, 5, 5, 6)),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Correo Electronico',
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 242, 237, 237)),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 232, 229, 229)),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    obscureText: true,
                    autofocus: false,
                    style: const TextStyle(
                        fontSize: 22.0, color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Contraseña',
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 100, right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      alignment: MainAxisAlignment.spaceBetween,
                      text: 'CONTINUAR',
                      icon: Icons.arrow_forward_ios_outlined,
                      color: Color.fromARGB(255, 241, 131, 186),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatList()),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
