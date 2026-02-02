import 'package:flutter/material.dart';

import '../../../../common/app_dimensions.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../utils/l10n.dart';

class EmptySearchPlaceholderWidget extends StatelessWidget {
  const EmptySearchPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppDimensions.normalL),
      child: Row(
        children: [
          Flexible(
            child: Text(
              AppLocalisations.emptySearchPlaceholderText,
              maxLines: 3,
              style: AppTextStyles.zonaPro18,
            ),
          ),
        ],
      ),
    );
  }
}
