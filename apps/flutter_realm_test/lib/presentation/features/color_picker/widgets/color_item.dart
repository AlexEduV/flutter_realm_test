import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_project/common/extensions/color_extension.dart';

class ColorItem extends StatelessWidget {
  const ColorItem({required this.color, required this.isPicked, required this.onTap, super.key});

  final Color color;
  final bool isPicked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Color.alphaBlend(AppColors.black.withAlpha(50), color),
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
