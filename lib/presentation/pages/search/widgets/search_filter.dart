import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';

import '../../../../common/app_dimensions.dart';
import '../../../../common/app_text_styles.dart';
import '../../../widgets/app_badge.dart';

class SearchFilter extends StatelessWidget {
  final String text;
  final String selectionCount;
  final double iconSize;
  final IconData icon;
  final void Function()? onPressed;

  const SearchFilter({
    required this.text,
    required this.icon,
    required this.selectionCount,
    this.onPressed,
    this.iconSize = 40.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.normalL,
        vertical: AppDimensions.contentPadding,
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDimensions.normalL),
          ),
          padding: EdgeInsets.all(AppDimensions.normalL),
          child: Row(
            spacing: AppDimensions.normalXS,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.normalXS),
                  color: AppColors.scaffoldColor,
                ),
                height: iconSize,
                width: iconSize,
                child: Icon(icon, color: AppColors.headerColor),
              ),

              Text(text, style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w600)),

              Spacer(),

              AppBadge(text: selectionCount),
            ],
          ),
        ),
      ),
    );
  }
}
