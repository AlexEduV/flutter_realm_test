import 'package:flutter/material.dart';

import '../../../../common/app_dimensions.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../utils/l10n.dart';

class ResultsWidget extends StatelessWidget {
  final String results;

  const ResultsWidget({required this.results, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppDimensions.minorL,
      children: [
        Text(AppLocalisations.results, style: AppTextStyles.zonaPro16),

        Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
          padding: EdgeInsets.all(AppDimensions.minorL),
          child: Text(results, style: AppTextStyles.zonaPro16.copyWith(color: Colors.white)),
        ),
      ],
    );
  }
}
