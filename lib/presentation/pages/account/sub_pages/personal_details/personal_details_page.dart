import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/presentation/pages/account/sub_pages/personal_details/widgets/personal_details_list_item.dart';
import 'package:test_futter_project/utils/l10n.dart';

import '../../../../../common/app_text_styles.dart';

class PersonalDetailsPage extends StatelessWidget {
  const PersonalDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text(AppLocalisations.accountItemPersonalDetails, style: AppTextStyles.zonaPro20),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.minorL),
        child: Container(
          margin: EdgeInsets.all(AppDimensions.minorL),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDimensions.normalL),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(AppDimensions.minorL),
            itemCount: 5,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final items = [
                {'title': 'First Name', 'description': 'Test', 'icon': Icons.person_pin_outlined},
                {'title': 'Last Name', 'description': 'Test', 'icon': Icons.person_outlined},
                {'title': 'Email', 'description': 'Test', 'icon': Icons.email_outlined},
                {'title': 'Phone Number', 'description': 'Test', 'icon': Icons.phone_outlined},
                {'title': 'Date of Birth', 'description': 'Test', 'icon': Icons.cake_outlined},
              ];
              final item = items[index];
              return PersonalDetailsListItem(
                title: item['title']! as String,
                description: item['description']! as String,
                icon: item['icon'] as IconData,
              );
            },
          ),
        ),
      ),
    );
  }
}
