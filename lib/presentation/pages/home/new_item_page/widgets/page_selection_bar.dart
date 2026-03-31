import 'package:flutter/material.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/app_dimensions.dart';

class PageSelectionBar extends StatelessWidget {
  final Function() onForwardPressed;
  final Function() onBackPressed;

  const PageSelectionBar({required this.onBackPressed, required this.onForwardPressed, super.key});

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

          IconButton(
            onPressed: onForwardPressed,
            icon: Icon(Icons.chevron_right_outlined, color: iconColor, size: iconSize),
          ),
        ],
      ),
    );
  }
}
