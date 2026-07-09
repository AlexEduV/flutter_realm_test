import 'package:flutter/material.dart';

import 'project_constraints/app_dimensions.dart';
import 'project_constraints/app_text_styles.dart';

class EmptyResultsPlaceholderWidget extends StatelessWidget {
  const EmptyResultsPlaceholderWidget({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.normalL),
      child: Text(
        text,
        maxLines: 3,
        style: AppTextStyles.zonaPro18,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
