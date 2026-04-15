import 'package:flutter/material.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';

import '../../common/constants/app_text_styles.dart';
import '../../l10n/l10n_keys.dart';

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
              context.tr(L10nKeys.comingSoonPlaceholderPageTitle),
              style: AppTextStyles.zonaPro24,
            ),
            const SizedBox(height: AppDimensions.minorL),
            Text(
              context.tr(L10nKeys.comingSoonPlaceholderPageSubTitle),
              style: AppTextStyles.zonaPro16.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
