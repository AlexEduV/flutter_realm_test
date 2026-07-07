import 'package:flutter/material.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';

import '../../../../../common/constants/app_text_styles.dart';

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
