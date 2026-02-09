import 'package:flutter/material.dart';

import '../../common/app_colors.dart';
import '../../common/app_dimensions.dart';

class AnimatedFavoriteIcon extends StatelessWidget {
  final bool isFavorite;

  const AnimatedFavoriteIcon({required this.isFavorite, super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteButtonSize = 38.0;

    return Container(
      width: favoriteButtonSize,
      height: favoriteButtonSize,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppDimensions.minorL)),
      child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: AppColors.gold),
    );
  }
}
