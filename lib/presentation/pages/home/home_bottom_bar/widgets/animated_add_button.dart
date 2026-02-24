import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';

import '../../../../../common/app_dimensions.dart';

class AnimatedAddButton extends StatefulWidget {
  final VoidCallback onPressed;
  const AnimatedAddButton({required this.onPressed, super.key});

  @override
  State<AnimatedAddButton> createState() => _AnimatedAddButtonState();
}

class _AnimatedAddButtonState extends State<AnimatedAddButton> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() => _scale = 1.15); // Slightly enlarge
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _scale = 1.0);
    widget.onPressed();
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Material(
          color: AppColors.headerColor,
          shape: const CircleBorder(),
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            splashColor: AppColors.accentColor.withAlpha(60), // Custom splash
            highlightColor: Colors.transparent,
            onTap: widget.onPressed,
            child: const Padding(
              padding: EdgeInsets.all(AppDimensions.minorL),
              child: Icon(
                Icons.add,
                size: AppDimensions.bottomAppBarIconEnlargedSize,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
