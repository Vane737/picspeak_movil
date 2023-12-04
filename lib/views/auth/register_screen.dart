// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:picspeak_front/views/auth/save_password_screen.dart';
import 'package:picspeak_front/config/theme/app_colors.dart';
import 'package:picspeak_front/views/widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primaryColor,
        child: ListView(padding: const EdgeInsets.all(16.0), children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 70.0),
                  child: Text(
                    'Crear una nueva cuenta',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      color: AppColors.textColor,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Por favor introduce tu correo electrónico para comenzar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.textColor,
                    fontFamily: 'Inter',
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 200.0, right: 20, left: 20),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    autofocus: true,
                    style: const TextStyle(
                        fontSize: 22.0, color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Correo electrónico',
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 150, right: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        alignment: MainAxisAlignment.spaceBetween,
                        icon: Icons.arrow_back_ios,
                        color: AppColors.bgSecondaryColor,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CustomButton(
                        alignment: MainAxisAlignment.spaceBetween,
                        text: 'CONTINUAR',
                        icon: Icons.arrow_forward_ios_outlined,
                        color: AppColors.bgSecondaryColor,
                        onPressed: () {
                          String userEmail = emailController.text;

                          if (userEmail.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SavePasswordScreen(userEmail: userEmail),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'El campo de correo electrónico no puede estar vacío.'),
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
