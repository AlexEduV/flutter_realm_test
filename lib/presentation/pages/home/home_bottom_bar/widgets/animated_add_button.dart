import 'package:flutter/material.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/app_dimensions.dart';
import '../../../../../utils/l10n.dart';

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
        child: IconButton(
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(AppColors.headerColor),
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
            overlayColor: WidgetStatePropertyAll(Colors.white.withAlpha(60)),
          ),
          icon: const Icon(Icons.add, size: AppDimensions.bottomAppBarIconEnlargedSize),
          onPressed: widget.onPressed,
          tooltip: AppLocalisations.addCarButtonTooltip,
        ),
      ),
    );
  }
}
