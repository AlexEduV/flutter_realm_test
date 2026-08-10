import 'package:flutter/material.dart';

import 'project_constraints/app_colors.dart';
import 'project_constraints/app_dimensions.dart';
import 'project_constraints/app_text_styles.dart';

enum ButtonType { primary, secondary }

class SplashButton extends StatelessWidget {
  const SplashButton({
    required this.title,
    required this.onPressed,
    this.buttonType = ButtonType.primary,
    this.isLoading = false,
    super.key,
  });

  final String title;
  final void Function() onPressed;
  final ButtonType buttonType;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = buttonType == ButtonType.primary ? Colors.white : Colors.grey;
    final backgroundColor = buttonType == ButtonType.primary ? AppColors.headerColor : Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.normalM),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: AppDimensions.normalM), // Button height
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.normalS),
            ),
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
          ),
          child: isLoading
              ? SizedBox(
                  height: AppDimensions.splashButtonProgressBarSize,
                  width: AppDimensions.splashButtonProgressBarSize,
                  child: CircularProgressIndicator(color: foregroundColor),
                )
              : Text(
                  title,
                  style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}
