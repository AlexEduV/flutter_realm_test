import 'package:flutter/material.dart';

import '../../common/constants/app_dimensions.dart';
import '../../common/constants/app_text_styles.dart';

class EmptyResultsPlaceholderWidget extends StatelessWidget {
  final String text;

  const EmptyResultsPlaceholderWidget({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.normalL),
      child: Row(
        children: [Flexible(child: Text(text, maxLines: 3, style: AppTextStyles.zonaPro18))],
      ),
    );
  }
}
