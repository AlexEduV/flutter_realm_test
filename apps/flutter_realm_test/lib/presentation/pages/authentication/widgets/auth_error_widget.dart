import 'package:flutter/material.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_dimensions.dart';
import '../../../../common/constants/app_text_styles.dart';

class AuthErrorWidget extends StatelessWidget {
  const AuthErrorWidget({this.text, super.key});

  final String? text;

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
          color: Colors.orange,
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
