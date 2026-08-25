import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class AppBadge extends StatelessWidget {
  const AppBadge({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Badge.count(
      count: count,
      backgroundColor: AppColors.black,
      padding: const EdgeInsets.all(AppDimensions.minorM),
      textStyle: AppTextStyles.zonaPro16White.copyWith(fontWeight: FontWeight.w600),
    );
  }
}
