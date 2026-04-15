import 'package:flutter/material.dart';
import 'package:test_flutter_project/common/constants/app_semantics_labels.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/presentation/widgets/app_badge.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';

import '../../../../common/constants/app_dimensions.dart';
import '../../../../common/constants/app_text_styles.dart';
import '../../../../l10n/l10n_keys.dart';

class ResultsWidget extends StatelessWidget {
  final String resultsCount;

  const ResultsWidget({required this.resultsCount, super.key});

  @override
  Widget build(BuildContext context) {
    return AppSemantics(
      label: '${AppSemanticsLabels.resultsLabel} $resultsCount',
      child: Row(
        spacing: AppDimensions.minorL,
        children: [
          Text(
            context.tr(L10nKeys.results),
            style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w600),
          ),

          AppBadge(text: resultsCount),
        ],
      ),
    );
  }
}
