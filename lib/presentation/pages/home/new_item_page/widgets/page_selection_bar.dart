import 'package:flutter/material.dart';
import 'package:test_futter_project/common/enums/item_setup_tab.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/app_dimensions.dart';

class PageSelectionBar extends StatelessWidget {
  final Function() onForwardPressed;
  final Function() onBackPressed;
  final int currentIndex;

  const PageSelectionBar({
    required this.onBackPressed,
    required this.onForwardPressed,
    required this.currentIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = AppColors.headerColor;
    final iconSize = AppDimensions.majorM;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.normalXL),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            offset: const Offset(0, AppDimensions.minorL),
            blurRadius: 16,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        spacing: AppDimensions.minorL,
        children: [
          IconButton(
            onPressed: onBackPressed,
            icon: Icon(Icons.chevron_left_outlined, color: iconColor, size: iconSize),
          ),

          ...ItemSetupTab.values.map((element) {
            final isCurrentIndex = element.index == currentIndex;

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
          }),

          IconButton(
            onPressed: onForwardPressed,
            icon: Icon(Icons.chevron_right_outlined, color: iconColor, size: iconSize),
          ),
        ],
      ),
    );
  }
}
