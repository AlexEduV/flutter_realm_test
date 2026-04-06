import 'package:flutter/material.dart';

import '../../../../../common/constants/app_colors.dart';

class AnimatedAddButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final double size;

  const AnimatedAddButton({
    required this.onPressed,
    required this.backgroundColor,
    required this.size,
    super.key,
  });

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
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: Material(
        color: widget.backgroundColor,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          splashColor: AppColors.accentColor.withAlpha(60),
          highlightColor: Colors.transparent,
          onTap: widget.onPressed,
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          child: CircleAvatar(
            backgroundColor: widget.backgroundColor,
            radius: widget.size,
            child: Icon(Icons.add, color: Colors.white, size: widget.size * 1.2),
          ),
        ),
      ),
    );
  }
}
