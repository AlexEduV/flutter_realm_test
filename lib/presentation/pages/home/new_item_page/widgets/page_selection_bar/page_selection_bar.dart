import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../../common/app_colors.dart';
import '../../../../../../common/app_dimensions.dart';

class PageSelectionBar extends StatelessWidget {
  final Function() onForwardPressed;
  final Function() onBackPressed;
  final int currentIndex;
  final Color iconColor;
  final double iconSize;

  const PageSelectionBar({
    required this.onBackPressed,
    required this.onForwardPressed,
    required this.currentIndex,
    this.iconSize = AppDimensions.majorM,
    this.iconColor = AppColors.headerColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dotSize = AppDimensions.normalS;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.majorM),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            offset: const Offset(0, AppDimensions.minorL),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        spacing: AppDimensions.minorL,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimensions.minorM),
            child: IconButton(
              icon: Icon(Icons.chevron_left_outlined, color: iconColor, size: iconSize),
              onPressed: onBackPressed,
            ),
          ),

          AnimatedSmoothIndicator(
            activeIndex: currentIndex,
            count: 3,
            effect: WormEffect(
              activeDotColor: AppColors.headerColor,
              dotColor: AppColors.placeholderColor,
              dotHeight: dotSize,
              dotWidth: dotSize,
            ),
          ),

          // end region --------------
          Padding(
            padding: const EdgeInsets.all(AppDimensions.minorM),
            child: IconButton(
              icon: Icon(Icons.chevron_right_outlined, color: iconColor, size: iconSize),
              onPressed: onForwardPressed,
            ),
          ),
        ],
      ),
    );
  }
}
