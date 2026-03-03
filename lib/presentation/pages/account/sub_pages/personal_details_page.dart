import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/utils/l10n.dart';

import '../../../../common/app_text_styles.dart';

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
          children: [Text('First Name'), Text('Last Name'), Text('Email'), Text('Phone Number')],
        ),
      ),
    );
  }
}
