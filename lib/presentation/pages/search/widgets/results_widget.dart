import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/presentation/widgets/app_badge.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';

import '../../../../common/app_dimensions.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../utils/l10n.dart';

class ResultsWidget extends StatelessWidget {
  final String results;

  const ResultsWidget({required this.results, super.key});

  @override
  Widget build(BuildContext context) {
    return AppSemantics(
      label: '${AppSemanticsLabels.resultsLabel} $results',
      child: Row(
        spacing: AppDimensions.minorL,
        children: [
          Text(
            AppLocalisations.results,
            style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w600),
          ),

          AppBadge(text: results),
        ],
      ),
    );
  }
}
