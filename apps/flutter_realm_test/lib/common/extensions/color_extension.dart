import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart' show Brightness, Color, ThemeData;

extension ContrastingColor on Color {
  Color getContrastingIconColor() {
    final brightness = ThemeData.estimateBrightnessForColor(this);
    return brightness == Brightness.dark ? AppColors.white : AppColors.black;
  }
}
