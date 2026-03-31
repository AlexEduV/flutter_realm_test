import 'package:flutter/material.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/app_dimensions.dart';

class PageSelectionBar extends StatelessWidget {
  final Function() onForwardPressed;
  final Function() onBackPressed;

  const PageSelectionBar({required this.onBackPressed, required this.onForwardPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.normalXL),
        color: Colors.white,
      ),
      child: Row(
        spacing: AppDimensions.minorL,
        children: [
          IconButton(
            onPressed: onBackPressed,
            icon: const Icon(Icons.chevron_left_outlined, color: AppColors.headerColor),
          ),

          IconButton(
            onPressed: onForwardPressed,
            icon: const Icon(Icons.chevron_right_outlined, color: AppColors.headerColor),
          ),
        ],
      ),
    );
  }
}
