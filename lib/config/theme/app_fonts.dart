import 'package:flutter/material.dart';
import 'package:picspeak_front/config/theme/app_colors.dart';

class AppFonts {
  static const String primaryFontFamily = 'Inter'; // Fuente predeterminada
  static const String secondFontFamily = 'JotiOne'; // Fuente predeterminada
  static const String subtitleFontFamily = 'Roboto'; // Fuente predeterminada

  static const TextStyle heading1Style = TextStyle(
    fontFamily: subtitleFontFamily,
    //fontWeight: FontWeight.bold,
    fontSize: 40,
    color: AppColors.textColor,
  );
  static const TextStyle heading2Style = TextStyle(
    fontFamily: primaryFontFamily,
    //fontWeight: FontWeight.bold,
    fontSize: 25,
  );
  static const TextStyle heading3Style = TextStyle(
    fontFamily: primaryFontFamily,
    //fontWeight: FontWeight.bold,
    fontSize: 20,
    color: AppColors.textColor,
  );
  static const TextStyle textStyle = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 20,
  );
  static const TextStyle smallTextStyle = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 16,
  );
  static const TextStyle buttonTextStyle = TextStyle(
    fontFamily: secondFontFamily,
    fontSize: 18,
    color: Colors.white
  );
  // Define más estilos de fuentes según tus necesidades
}