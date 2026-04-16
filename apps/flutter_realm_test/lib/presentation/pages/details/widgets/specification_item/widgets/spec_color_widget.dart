import 'package:flutter/material.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';

class SpecColorWidget extends StatelessWidget {
  final Color? color;

  const SpecColorWidget({this.color, super.key});

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
