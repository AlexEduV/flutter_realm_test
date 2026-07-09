import 'package:flutter/material.dart';
import 'package:realm_ui_core/realm_ui_core.dart';

class SpecColorWidget extends StatelessWidget {
  const SpecColorWidget({this.color, super.key});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final size = 20.0;

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(
          color: Color.alphaBlend(Colors.black.withAlpha(50), color ?? Colors.black),
          width: AppDimensions.minorXS,
        ),
      ),
    );
  }
}
