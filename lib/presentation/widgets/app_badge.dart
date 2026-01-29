import 'package:flutter/material.dart';

import '../../common/app_dimensions.dart';
import '../../common/app_text_styles.dart';

class AppBadge extends StatelessWidget {
  final String text;

  const AppBadge({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
      padding: EdgeInsets.all(AppDimensions.minorL),
      child: Text(text, style: AppTextStyles.zonaPro16.copyWith(color: Colors.white)),
    );
  }
}
