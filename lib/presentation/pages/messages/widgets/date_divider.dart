import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';

import '../../../../common/app_colors.dart';

class DateDivider extends StatelessWidget {
  final String text;

  const DateDivider({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.normalS),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.minorL),
            decoration: BoxDecoration(
              color: AppColors.whiteGrey,
              borderRadius: BorderRadius.circular(AppDimensions.normalM),
            ),
            child: Text(text, style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
