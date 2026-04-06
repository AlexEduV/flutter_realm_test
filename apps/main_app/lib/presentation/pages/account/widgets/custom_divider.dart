import 'package:flutter/material.dart';
import 'package:test_futter_project/common/constants/app_dimensions.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1.0,
      indent: AppDimensions.normalM,
      endIndent: AppDimensions.normalM,
      color: Colors.grey.withAlpha(80),
    );
  }
}
