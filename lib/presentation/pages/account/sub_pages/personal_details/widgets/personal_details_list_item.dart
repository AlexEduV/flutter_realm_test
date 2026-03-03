import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';

class PersonalDetailsListItem extends StatelessWidget {
  final String title;
  final String description;
  final Function()? onTap;

  const PersonalDetailsListItem({
    required this.title,
    required this.description,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.minorM),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w400),
            ),
          ),

          Text(description, style: AppTextStyles.zonaPro16.copyWith(color: Colors.grey[600])),

          if (onTap != null) ...[const Icon(Icons.chevron_right_rounded, size: 16.0)],
        ],
      ),
    );
  }
}
