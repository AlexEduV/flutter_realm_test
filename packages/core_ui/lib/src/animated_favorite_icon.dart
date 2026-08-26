import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class AnimatedFavoriteIcon extends StatefulWidget {
  const AnimatedFavoriteIcon({
    required this.isFavorite,
    required this.size,
    this.isDecorated = true,
    super.key,
  });

  final bool isFavorite;
  final double size;
  final bool isDecorated;

  @override
  State<AnimatedFavoriteIcon> createState() => _AnimatedFavoriteIconState();
}

class _AnimatedFavoriteIconState extends State<AnimatedFavoriteIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  final _animationSequence = TweenSequence([
    // First Pulse (The "Lub")
    TweenSequenceItem(
      tween: Tween(begin: 1.0, end: 1.25).chain(CurveTween(curve: Curves.easeOut)),
      weight: 25,
    ),
    TweenSequenceItem(
      tween: Tween(begin: 1.25, end: 1.0).chain(CurveTween(curve: Curves.easeIn)),
      weight: 25,
    ),
    // Second Pulse (The "Dub" - identical in scale)
    TweenSequenceItem(
      tween: Tween(begin: 1.0, end: 1.25).chain(CurveTween(curve: Curves.easeOut)),
      weight: 25,
    ),
    TweenSequenceItem(
      tween: Tween(begin: 1.25, end: 1.0).chain(CurveTween(curve: Curves.easeIn)),
      weight: 25,
    ),
  ]);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 450), vsync: this);
    _scaleAnimation = _animationSequence.animate(_controller);
  }

  @override
  void didUpdateWidget(covariant AnimatedFavoriteIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isFavorite && widget.isFavorite) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: widget.size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: widget.isDecorated ? BorderRadius.circular(AppDimensions.minorL) : null,
        ),
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) => Transform.scale(
            scale: widget.isFavorite ? _scaleAnimation.value : 1.0,
            child: Stack(
              alignment: AlignmentGeometry.center,
              children: [
                Icon(
                  widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: widget.isFavorite ? AppColors.gold : AppColors.black,
                ),

                if (widget.isFavorite) ...[
                  const Icon(Icons.favorite_border, color: AppColors.mutedGold),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
