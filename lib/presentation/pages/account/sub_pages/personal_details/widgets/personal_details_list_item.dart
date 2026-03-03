import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_text_styles.dart';

class PersonalDetailsListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Function()? onTap;

  const PersonalDetailsListItem({
    required this.icon,
    required this.title,
    required this.description,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: AppTextStyles.zonaPro16),
      subtitle: Text(description, style: AppTextStyles.zonaPro16.copyWith(color: Colors.grey[600])),
      leading: Icon(icon),
    );
  }
}
