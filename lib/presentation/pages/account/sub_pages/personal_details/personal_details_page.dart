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
      body: const Padding(
        padding: EdgeInsets.all(AppDimensions.minorL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PersonalDetailsListItem(
              title: 'First Name',
              description: 'Test',
              icon: Icons.person_pin_outlined,
            ),
            PersonalDetailsListItem(
              title: 'Last Name',
              description: 'Test',
              icon: Icons.person_outlined,
            ),
            PersonalDetailsListItem(
              title: 'Email',
              description: 'Test',
              icon: Icons.email_outlined,
            ),
            PersonalDetailsListItem(
              title: 'Phone Number',
              description: 'Test',
              icon: Icons.phone_outlined,
            ),
            PersonalDetailsListItem(
              title: 'Date of Birth',
              description: 'Test',
              icon: Icons.cake_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
