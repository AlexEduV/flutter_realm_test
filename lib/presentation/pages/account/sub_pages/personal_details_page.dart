import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';

import '../../../../common/app_text_styles.dart';

class PersonalDetailsPage extends StatelessWidget {
  const PersonalDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: const Text('Personal Details', style: AppTextStyles.zonaPro20),
        centerTitle: true,
      ),
      body: const Column(children: [Text('First Name')]),
    );
  }
}
