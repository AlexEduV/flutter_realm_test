import 'package:flutter/material.dart';

import '../../../../common/app_dimensions.dart';

class DividerWithText extends StatelessWidget {
  final String text;

  const DividerWithText({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.normalM),
      child: Row(
        children: <Widget>[
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.minorL),
            child: Text(text),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }
}
