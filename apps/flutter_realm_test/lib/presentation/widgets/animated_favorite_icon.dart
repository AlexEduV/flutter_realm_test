import 'package:flutter/material.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';

import '../../common/constants/app_colors.dart';

class AnimatedFavoriteIcon extends StatefulWidget {
  final bool isFavorite;
  final double size;
  final bool decorated;

  const AnimatedFavoriteIcon({
    required this.isFavorite,
    required this.size,
    this.decorated = true,
    super.key,
  });

  @override
  State<AnimatedFavoriteIcon> createState() => _AnimatedFavoriteIconState();
}

class _AnimatedFavoriteIconState extends State<AnimatedFavoriteIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 450), vsync: this);
    _scaleAnimation = TweenSequence([
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
    ]).animate(_controller);
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
    return Container(
      height: widget.size,
      width: widget.size,
      decoration: widget.decorated
          ? BoxDecoration(borderRadius: BorderRadius.circular(AppDimensions.minorL))
          : null,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: widget.isFavorite ? _scaleAnimation.value : 1.0,
          child: Stack(
            alignment: AlignmentGeometry.center,
            children: [
              Icon(
                widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: widget.isFavorite ? AppColors.gold : Colors.black,
              ),

              if (widget.isFavorite) ...[
                const Icon(Icons.favorite_border, color: AppColors.mutedGold),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
