import 'package:flutter/material.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';

import '../../../../../../common/constants/app_dimensions.dart';
import '../../../../../../common/constants/app_text_styles.dart';
import '../../../../../../l10n/l10n_keys.dart';

class GifLabel extends StatelessWidget {
  const GifLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.minorM),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.normalS),
      ),
      child: Text(
        context.tr(L10nKeys.gifMessagePlaceholder),
        style: AppTextStyles.zonaPro14.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
