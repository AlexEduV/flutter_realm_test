import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';

class RadioGroupTitle extends StatelessWidget {
  const RadioGroupTitle({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: AppTextStyles.zonaPro14.copyWith(
            color: AppColors.placeholderColorDark,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
