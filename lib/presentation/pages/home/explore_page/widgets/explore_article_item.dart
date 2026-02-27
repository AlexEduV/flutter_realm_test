import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';

import '../../../../../common/app_colors.dart';

class ExploreArticleItem extends StatelessWidget {
  final double height;
  final String articleName;

  const ExploreArticleItem({required this.articleName, this.height = 120.0, super.key});

  @override
  Widget build(BuildContext context) {
    return AppSemantics(
      label: AppSemanticsLabels.exploreArticleItem,
      button: true,
      child: Material(
        color: AppColors.accentColor.withAlpha(60),
        borderRadius: BorderRadius.circular(AppDimensions.normalL),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(AppDimensions.normalL),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppDimensions.normalL)),
            height: height,
            width: 120,
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.minorL),
              child: Align(
                alignment: AlignmentGeometry.bottomLeft,
                child: Text(articleName, maxLines: 2, style: AppTextStyles.zonaPro16White),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
