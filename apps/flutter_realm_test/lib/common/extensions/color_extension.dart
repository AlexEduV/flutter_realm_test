import 'package:flutter/material.dart' show Brightness, Color, Colors, ThemeData;

extension ContrastingColor on Color {
  Color getContrastingIconColor() {
    final brightness = ThemeData.estimateBrightnessForColor(this);
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }
}
