import 'dart:ui' show Color;

abstract class CarColorRepository {
  Map<String, Color> getColors();
  Color? getColorByName(String colorName);
  String getColorNameFromColor(Color? color);
}
