// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart'
    show
        BorderRadius,
        BorderSide,
        BuildContext,
        Center,
        Color,
        Colors,
        Column,
        Container,
        EdgeInsets,
        InputDecoration,
        MainAxisAlignment,
        MaterialPageRoute,
        Navigator,
        OutlineInputBorder,
        Scaffold,
        StatelessWidget,
        Text,
        TextAlign,
        TextField,
        TextStyle,
        UnderlineInputBorder,
        Widget;
import 'package:flutter/widgets.dart';
import 'package:picspeak_front/config/theme/app_colors.dart';
import 'package:picspeak_front/views/screens/nationalitity_screen.dart';
import 'package:picspeak_front/views/widgets/custom_button.dart';

class ValidateEmailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 70.0),
                child: Text(
                  'Verifica tu correo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: AppColors.textColor,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              const Text(
                'Porfavor, ingresa el código de verificación que enviamos a tu correo electrónico',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.textColor,
                  fontFamily: 'Inter',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  obscureText: false,
                  autofocus: false,
                  style: const TextStyle(
                      fontSize: 22.0, color: Color.fromARGB(255, 5, 5, 6)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Código de verificación',
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
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80, right: 50, left: 50),
                child: CustomButton(
                  alignment: MainAxisAlignment.center,
                  icon: null,
                  text: 'VERIFICAR',
                  color: AppColors.bgPrimaryColor,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NationalityScreen()),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
