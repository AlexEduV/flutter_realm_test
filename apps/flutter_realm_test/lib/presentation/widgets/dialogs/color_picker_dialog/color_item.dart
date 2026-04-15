import 'package:flutter/material.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/common/extensions/color_extension.dart';

class ColorItem extends StatelessWidget {
  final Color color;
  final bool isPicked;
  final VoidCallback onTap;

  const ColorItem({required this.color, required this.isPicked, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(120.0);

    return Material(
      color: color,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Color.alphaBlend(Colors.black.withAlpha(50), color),
              width: AppDimensions.minorXS,
            ),
          ),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            opacity: isPicked ? 1.0 : 0.0,
            child: Icon(Icons.done, color: color.getContrastingIconColor()),
          ),
        ),
      ),
    );
  }
}
