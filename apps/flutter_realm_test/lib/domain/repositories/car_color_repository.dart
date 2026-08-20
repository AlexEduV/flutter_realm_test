import 'dart:ui' show Color;

abstract interface class CarColorRepository {
  Map<String, Color> getColors();
  Color? getColorByName(String colorName);
  String getColorNameFromColor(Color? color);
}
