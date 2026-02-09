import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';

class AnimatedFavoriteIcon extends StatelessWidget {
  final bool isFavorite;

  const AnimatedFavoriteIcon({required this.isFavorite, super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteButtonSize = 38.0;

    return Container(
      height: favoriteButtonSize,
      width: favoriteButtonSize,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.minorL),
      ),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: isFavorite ? 300 : 0),
        transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
        child: TweenAnimationBuilder<double>(
          key: ValueKey(isFavorite),
          tween: isFavorite
              ? Tween<double>(begin: 1.0, end: 1.0)
              : Tween<double>(begin: 1.0, end: 1.0),
          duration: Duration(milliseconds: isFavorite ? 300 : 0),
          curve: Curves.easeInOut,
          builder: (context, scale, child) => Transform.scale(
            scale: scale,
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? AppColors.gold : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
