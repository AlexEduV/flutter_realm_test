import 'package:flutter/material.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimensions.dart';
import '../../../../common/app_text_styles.dart';

class AuthErrorWidget extends StatelessWidget {
  final String? text;

  const AuthErrorWidget({this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      opacity: text == null ? 0 : 1,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.normalM,
          vertical: AppDimensions.minorS,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: AppDimensions.normalM,
          vertical: AppDimensions.normalM,
        ),
        decoration: BoxDecoration(
          color: Colors.red.withAlpha(60),
          borderRadius: BorderRadius.circular(AppDimensions.minorL),
        ),
        child: Text(
          text ?? '',
          style: AppTextStyles.zonaPro16.copyWith(color: AppColors.cherryRed),
        ),
      ),
    );
  }
}
