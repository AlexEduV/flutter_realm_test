import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';

class ExploreSectionItem extends StatelessWidget {
  final double height;
  final String articleName;

  const ExploreSectionItem({required this.articleName, this.height = 120.0, super.key});

  @override
  Widget build(BuildContext context) {
    return AppSemantics(
      label: AppSemanticsLabels.exploreSectionItem,
      button: true,
      enabled: false,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.normalL),
          color: AppColors.placeholderColor,
        ),
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
    );
  }
}
