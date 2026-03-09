import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/utils/l10n/l10n.dart';

import '../../../../common/app_text_styles.dart';

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.hourglass_empty,
              size: AppDimensions.placeholderPageIconSize,
              color: Colors.grey,
            ),
            const SizedBox(height: AppDimensions.normalM),
            Text(
              AppLocalisations.of(context).comingSoonPlaceholderPageTitle,
              style: AppTextStyles.zonaPro24,
            ),
            const SizedBox(height: AppDimensions.minorL),
            Text(
              AppLocalisations.of(context).comingSoonPlaceholderPageSubTitle,
              style: AppTextStyles.zonaPro16.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
