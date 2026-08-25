import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

import '../../core_ui.dart';

class SplashButtonThemeData extends ThemeExtension<SplashButtonThemeData> {
  const SplashButtonThemeData({
    this.primaryBackgroundColor = AppColors.headerColor,
    this.primaryForegroundColor = AppColors.white,
    this.secondaryBackgroundColor = AppColors.white,
    this.secondaryForegroundColor = AppColors.grey,
    this.padding = const EdgeInsets.symmetric(vertical: AppDimensions.normalM),
    this.horizontalMargin = AppDimensions.normalM,
    this.borderRadius = AppDimensions.normalS,
    this.labelStyle,
    this.progressBarSize = AppDimensions.splashButtonProgressBarSize,
  });

  final Color primaryBackgroundColor;
  final Color primaryForegroundColor;
  final Color secondaryBackgroundColor;
  final Color secondaryForegroundColor;
  final EdgeInsetsGeometry padding;
  final double horizontalMargin;
  final double borderRadius;
  final TextStyle? labelStyle;
  final double progressBarSize;

  @override
  SplashButtonThemeData copyWith({
    Color? primaryBackgroundColor,
    Color? primaryForegroundColor,
    Color? secondaryBackgroundColor,
    Color? secondaryForegroundColor,
    EdgeInsetsGeometry? padding,
    double? horizontalMargin,
    double? borderRadius,
    TextStyle? labelStyle,
    double? progressBarSize,
  }) {
    return SplashButtonThemeData(
      primaryBackgroundColor: primaryBackgroundColor ?? this.primaryBackgroundColor,
      primaryForegroundColor: primaryForegroundColor ?? this.primaryForegroundColor,
      secondaryBackgroundColor: secondaryBackgroundColor ?? this.secondaryBackgroundColor,
      secondaryForegroundColor: secondaryForegroundColor ?? this.secondaryForegroundColor,
      padding: padding ?? this.padding,
      horizontalMargin: horizontalMargin ?? this.horizontalMargin,
      borderRadius: borderRadius ?? this.borderRadius,
      labelStyle: labelStyle ?? this.labelStyle,
      progressBarSize: progressBarSize ?? this.progressBarSize,
    );
  }

  @override
  SplashButtonThemeData lerp(ThemeExtension<SplashButtonThemeData>? other, double t) {
    if (other is! SplashButtonThemeData) return this;
    return SplashButtonThemeData(
      primaryBackgroundColor: Color.lerp(primaryBackgroundColor, other.primaryBackgroundColor, t)!,
      primaryForegroundColor: Color.lerp(primaryForegroundColor, other.primaryForegroundColor, t)!,
      secondaryBackgroundColor: Color.lerp(
        secondaryBackgroundColor,
        other.secondaryBackgroundColor,
        t,
      )!,
      secondaryForegroundColor: Color.lerp(
        secondaryForegroundColor,
        other.secondaryForegroundColor,
        t,
      )!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      horizontalMargin: lerpDouble(horizontalMargin, other.horizontalMargin, t)!,
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t)!,
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t),
      progressBarSize: lerpDouble(progressBarSize, other.progressBarSize, t)!,
    );
  }
}
