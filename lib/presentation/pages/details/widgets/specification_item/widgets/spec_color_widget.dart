import 'package:flutter/material.dart';

import '../../../../../../di/injection_container.dart';
import '../../../../../../domain/usecases/car_colors/get_car_colors_use_case.dart';

class SpecColorWidget extends StatelessWidget {
  final String? color;

  const SpecColorWidget({this.color, super.key});

  @override
  Widget build(BuildContext context) {
    final size = 20.0;
    final backgroundColor = serviceLocator<GetCarColorsUseCase>().call()[color?.toLowerCase()];

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: Border.all(
          color: Color.alphaBlend(Colors.black.withAlpha(50), backgroundColor ?? Colors.black),
          width: 2.0,
        ),
      ),
    );
  }
}
