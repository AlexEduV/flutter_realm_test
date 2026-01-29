import 'package:flutter/material.dart';

import '../../common/app_text_styles.dart';

class AppBadge extends StatelessWidget {
  final String text;

  const AppBadge({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: AppTextStyles.zonaPro16.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
