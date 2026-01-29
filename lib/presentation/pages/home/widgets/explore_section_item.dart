import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';

class ExploreSectionItem extends StatelessWidget {
  final double height;

  const ExploreSectionItem({super.key, this.height = 120.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.normalS),
        color: AppColors.placeholderColor,
      ),
      height: height,
      width: 120,
    );
  }
}
