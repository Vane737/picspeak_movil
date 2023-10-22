import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

class AppTextStyles {
  static TextStyle headingConfig = AppFonts.heading1Style.copyWith(
    color: AppColors.primaryColor,
  );
  static TextStyle inputLightTextStyle = AppFonts.textStyle.copyWith(
    color: const Color(0x71000000),
  );
  static TextStyle inputWhiteTextStyle = AppFonts.smallTextStyle.copyWith(
    color: const Color(0xFFE5E5E5),
  );
  // Define más estilos de texto según tus necesidades
  
}