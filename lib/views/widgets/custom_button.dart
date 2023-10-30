import 'package:flutter/material.dart';
import 'package:picspeak_front/config/theme/app_fonts.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final double? width;
  final IconData? icon;
  final Color color;
  final VoidCallback? onPressed;
  final MainAxisAlignment alignment; // Función que se llama cuando se presiona el botón

  const CustomButton({
    Key? key,
    this.width,
    this.text = '',
    required this.icon,
    required this.color,
    this.onPressed, required this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Material(
        color: color,
        child: InkWell(
          onTap: onPressed, // Llama a la función cuando se presiona el botón
          child: Container(
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              mainAxisAlignment: alignment,
              children: [
                Text(text!, style: AppFonts.buttonTextStyle),
                // Expanded(child: Container()),
                if (icon != null) Icon(icon, color: Colors.white)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
