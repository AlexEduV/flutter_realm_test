import 'package:flutter/material.dart';
import 'package:realm_ui_core/realm_ui_core.dart';

class EmptyResultsPlaceholderWidget extends StatelessWidget {
  const EmptyResultsPlaceholderWidget({required this.text, super.key});

  final String text;

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
