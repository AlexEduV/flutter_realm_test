import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';

import '../search_page_identifiers.dart';

class ResultsWidget extends StatelessWidget {
  const ResultsWidget({required this.resultsCount, super.key});

  final int resultsCount;

  @override
  Widget build(BuildContext context) {
    return AppSemantics(
      label: '${SearchPageIds.resultsLabel} $resultsCount',
      child: Row(
        spacing: AppDimensions.minorL,
        children: [
          Text(
            context.tr(SearchPageLocaleKeys.results),
            style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w600),
          ),

          Badge.count(
            count: resultsCount,
            backgroundColor: AppColors.black,
            padding: const EdgeInsets.all(6),
            textStyle: AppTextStyles.zonaPro16White.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
