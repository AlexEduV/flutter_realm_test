import 'package:flutter/material.dart';
import 'package:realm_ui_core/realm_ui_core.dart';

class VerifiedBadge extends StatelessWidget {
  const VerifiedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.minorS),
      child: Icon(Icons.beenhere_outlined, color: Colors.green[700], size: AppDimensions.normalL),
    );
  }
}
