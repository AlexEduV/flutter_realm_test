import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';

import '../../../../common/app_text_styles.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(title: const Text('Inbox', style: AppTextStyles.zonaPro20), centerTitle: true),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsetsGeometry.symmetric(
              horizontal: AppDimensions.normalM,
              vertical: AppDimensions.minorL,
            ),
            child: Row(
              spacing: AppDimensions.normalM,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.placeholderColor,
                  radius: AppDimensions.normalXL,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full Name',
                      style: AppTextStyles.zonaPro18.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Last Message',
                      style: AppTextStyles.zonaPro16Grey.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: 3,
      ),
    );
  }
}
