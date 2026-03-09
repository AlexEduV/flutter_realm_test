import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';

class PersonalDetailsListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Function()? onTap;
  final bool? showEnabled;

  const PersonalDetailsListItem({
    required this.icon,
    required this.title,
    required this.description,
    this.onTap,
    this.showEnabled,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppSemantics(
      label: '${AppSemanticsLabels.personalDetailsItem} $title',
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppDimensions.normalS),
        title: Text(title, style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w600)),
        onTap: onTap,
        subtitle: Row(
          spacing: AppDimensions.minorL,
          children: [
            if (showEnabled != null) ...[
              CircleAvatar(
                backgroundColor: (showEnabled ?? false) ? AppColors.tealColor : Colors.grey,
                radius: AppDimensions.normalXS,
                child: Icon(
                  (showEnabled ?? false) ? Icons.check : Icons.pause,
                  color: Colors.white,
                  size: AppDimensions.normalS,
                ),
              ),
            ],

            Text(
              description,
              style: AppTextStyles.zonaPro16.copyWith(color: AppColors.placeholderColorDark),
            ),
          ],
        ),
        leading: Icon(icon),
      ),
    );
  }
}
