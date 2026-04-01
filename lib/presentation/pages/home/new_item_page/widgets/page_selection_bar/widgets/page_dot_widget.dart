import 'package:flutter/material.dart';

import '../../../../../../../common/app_colors.dart';
import '../../../../../../../common/app_dimensions.dart';

class PageDotWidget extends StatelessWidget {
  final bool isCurrentIndex;

  const PageDotWidget({required this.isCurrentIndex, super.key});

  @override
  Widget build(BuildContext context) {
    const double baseSize = AppDimensions.normalS;
    final size = isCurrentIndex ? baseSize + AppDimensions.minorXS : baseSize;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCurrentIndex ? AppColors.headerColor : AppColors.placeholderColor,
      ),
    );
  }
}
