import 'package:flutter/material.dart';

import '../../../../../../../common/app_colors.dart';
import '../../../../../../../common/app_dimensions.dart';

class PageDotWidget extends StatelessWidget {
  final bool isCurrentIndex;

  const PageDotWidget({required this.isCurrentIndex, super.key});

  @override
  Widget build(BuildContext context) {
    const double baseSize = 12;
    final size = isCurrentIndex ? baseSize + AppDimensions.minorXS : baseSize;

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCurrentIndex ? Colors.white : AppColors.headerColor,
        border: Border.all(color: Colors.black),
      ),
    );
  }
}
