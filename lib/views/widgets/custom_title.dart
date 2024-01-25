import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    super.key,
    required this.headingText,
    required this.styles,
  });

  final String headingText;
  final TextStyle styles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70.0, bottom: 20),
      child: Text(headingText, style: styles, textAlign: TextAlign.center),
    );
  }
}
