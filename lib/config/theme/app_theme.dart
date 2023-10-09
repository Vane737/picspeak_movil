import 'package:flutter/material.dart';


const List<Color> _colorThemes = [
  Color.fromARGB(255, 228, 187, 199),
  Color(0xff9DCAB3),
  Color(0xffE25132),
  Color(0xffF6F3F0),
  Color(0xff373A39),
  Color(0xff0B799E),
  Color(0xffEFA818),
  Color.fromARGB(255, 244, 200, 212)
];

class AppTheme {
  final int selectedColor;
 

  AppTheme({
    this.selectedColor = 0
     }): assert( selectedColor >= 0 && selectedColor <= _colorThemes.length - 1,
      'Colors must be between 0 and ${_colorThemes.length}');

  ThemeData getTheme() {
    return ThemeData(
      // useMaterial3: true
      colorSchemeSeed: _colorThemes[selectedColor],
    );
  }
}
