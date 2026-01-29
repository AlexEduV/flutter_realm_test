import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/utils/l10n.dart';

class FilterDrawer extends StatelessWidget {
  final List<String> models;

  const FilterDrawer({required this.models, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: 2 + models.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return DrawerHeader(
              child: Text(AppLocalisations.searchFilterModelTitle, style: AppTextStyles.zonaPro20),
            );
          } else if (index == 1) {
            return ListTile(
              leading: Checkbox(value: true, onChanged: (value) {}),
              title: Text(AppLocalisations.searchFilterModelPlaceholder),
            );
          } else {
            return ListTile(title: Text(models[index - 2]));
          }
        },
      ),
    );
  }
}
