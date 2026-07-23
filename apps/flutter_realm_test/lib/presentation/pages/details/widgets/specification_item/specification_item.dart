import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';

class SpecificationItem extends StatelessWidget {
  const SpecificationItem({required this.title, required this.subtitle, this.leading, super.key});

  final String title;
  final String subtitle;
  final Widget? leading;

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
            ...[if (leading != null) leading!],

            Text(subtitle, style: AppTextStyles.zonaPro18.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}
