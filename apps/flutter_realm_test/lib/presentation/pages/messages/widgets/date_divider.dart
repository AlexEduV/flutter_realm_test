import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';

class DateDivider extends StatelessWidget {
  const DateDivider({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.normalS, top: AppDimensions.normalL),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.normalM,
              vertical: AppDimensions.minorXS,
            ),
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
