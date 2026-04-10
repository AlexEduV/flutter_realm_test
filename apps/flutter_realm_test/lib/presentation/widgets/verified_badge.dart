import 'package:flutter/material.dart';

import '../../common/constants/app_dimensions.dart';

class VerifiedBadge extends StatelessWidget {
  const VerifiedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.minorS),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green[700]),
      child: const Icon(Icons.check, color: Colors.white, size: AppDimensions.normalXS),
    );
  }
}
