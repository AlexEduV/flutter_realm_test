import 'package:flutter/material.dart';

import '../../../../common/app_dimensions.dart';
import '../../../../common/app_text_styles.dart';

class SplashButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool isLoading;

  const SplashButton({
    required this.title,
    required this.onPressed,
    required this.foregroundColor,
    required this.backgroundColor,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final progressBarSize = 23.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.normalM),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: AppDimensions.normalM), // Button height
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.normalS,
              ), // Optional rounded corners
            ),
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
          ),
          child: isLoading
              ? SizedBox(
                  height: progressBarSize,
                  width: progressBarSize,
                  child: CircularProgressIndicator(color: foregroundColor),
                )
              : Text(title, style: AppTextStyles.zonaPro16, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
