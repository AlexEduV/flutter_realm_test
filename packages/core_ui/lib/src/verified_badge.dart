import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class VerifiedBadge extends StatelessWidget {
  const VerifiedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.minorS),
      child: Icon(Icons.beenhere_outlined, color: AppColors.verified, size: AppDimensions.normalL),
    );
  }
}
