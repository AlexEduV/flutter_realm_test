import 'package:flutter/material.dart' show FontWeight, TextStyle;
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/extensions/text_style_extension.dart';

class AppTextStyles {
  static const zonaPro14 = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  static const zonaPro16 = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  static const zonaPro18 = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  static const zonaPro20 = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
  static const zonaPro24 = TextStyle(fontSize: 24, fontWeight: FontWeight.w600);
  static const zonaPro30 = TextStyle(fontSize: 30, fontWeight: FontWeight.w700);

  static final zonaPro30White = zonaPro30.whiten();
  static final zonaPro24White = zonaPro24.whiten();
  static final zonaPro18White = zonaPro18.whiten();
  static final zonaPro16White = zonaPro16.whiten();
  static final zonaPro14White = zonaPro14.whiten();

  static final zonaPro16Grey = zonaPro16.copyWith(color: AppColors.placeholderColorDark);
}
