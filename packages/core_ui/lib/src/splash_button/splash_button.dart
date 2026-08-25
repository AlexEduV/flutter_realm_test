import 'package:core_ui/src/splash_button/splash_button_theme.dart';
import 'package:flutter/material.dart';

import '../project_constraints/app_text_styles.dart';

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
    final theme =
        Theme.of(context).extension<SplashButtonThemeData>() ?? const SplashButtonThemeData();

    final isPrimary = buttonType == ButtonType.primary;
    final foregroundColor = isPrimary ? theme.primaryForegroundColor : theme.secondaryForegroundColor;
    final backgroundColor = isPrimary ? theme.primaryBackgroundColor : theme.secondaryBackgroundColor;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: theme.horizontalMargin),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: theme.padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(theme.borderRadius),
            ),
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
          ),
          child: isLoading
              ? SizedBox(
                  height: theme.progressBarSize,
                  width: theme.progressBarSize,
                  child: CircularProgressIndicator(color: foregroundColor),
                )
              : Text(
                  title,
                  style: theme.labelStyle ?? AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}
