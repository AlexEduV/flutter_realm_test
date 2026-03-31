import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';

class SpecificationItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? leading;

  const SpecificationItem({required this.title, required this.subtitle, this.leading, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppDimensions.minorXS,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.zonaPro16Grey.copyWith(fontWeight: FontWeight.w500)),
        Row(
          spacing: AppDimensions.minorL,
          children: [
            ?leading,

            Text(subtitle, style: AppTextStyles.zonaPro18.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}
