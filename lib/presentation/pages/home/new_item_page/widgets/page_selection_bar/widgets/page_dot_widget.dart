import 'package:flutter/material.dart';

import '../../../../../../../common/app_colors.dart';
import '../../../../../../../common/app_dimensions.dart';

class PageDotWidget extends StatelessWidget {
  const PageDotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const double baseSize = AppDimensions.normalS;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
      height: baseSize,
      width: baseSize,
      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.placeholderColor),
    );
  }
}
