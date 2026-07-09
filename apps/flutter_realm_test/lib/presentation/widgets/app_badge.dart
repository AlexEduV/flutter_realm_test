import 'package:flutter/material.dart';
import 'package:realm_ui_core/realm_ui_core.dart';

class AppBadge extends StatelessWidget {
  const AppBadge({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final size = 30.0;

    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: AppTextStyles.zonaPro16White.copyWith(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
