import 'package:flutter/material.dart';

import '../../common/constants/app_text_styles.dart';

class AppBadge extends StatelessWidget {
  final String text;

  const AppBadge({required this.text, super.key});

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
