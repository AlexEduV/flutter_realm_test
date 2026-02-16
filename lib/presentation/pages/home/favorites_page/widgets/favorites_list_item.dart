import 'package:flutter/material.dart';
import 'package:test_futter_project/common/extensions/string_extension.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/app_dimensions.dart';
import '../../../../../common/app_text_styles.dart';
import '../../../../../utils/app_router.dart';

class FavoritesListItem extends StatelessWidget {
  final CarEntity car;
  final Function()? onDeleteCallback;

  const FavoritesListItem({required this.car, this.onDeleteCallback, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppDimensions.normalL,
        left: AppDimensions.normalL,
        right: AppDimensions.normalL,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(AppDimensions.normalXL),
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppDimensions.normalXL),
          onTap: () => AppRouter.goToDetailsRouteFromExplore(car.carId),
          child: Container(
            key: ValueKey(car.carId),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppDimensions.normalXL)),
            padding: const EdgeInsets.all(AppDimensions.normalM),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Car Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimensions.normalM),
                  child: ColoredBox(
                    color: AppColors.placeholderColor ?? Colors.grey,
                    child: const SizedBox(
                      width: AppDimensions.favoriteItemPictureSize,
                      height: AppDimensions.favoriteItemPictureSize,
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.normalM),
                // Car Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${car.manufacturer} ${car.model} ${car.year}',
                        style: AppTextStyles.zonaPro18,
                      ),
                      const SizedBox(height: AppDimensions.minorS),
                      Row(
                        children: [
                          Icon(
                            Icons.directions_car,
                            size: AppDimensions.normalM,
                            color: AppColors.placeholderColorDark,
                          ),
                          const SizedBox(width: AppDimensions.minorL),
                          Text(
                            car.bodyType.capitalizeFirst(),
                            style: AppTextStyles.zonaPro14.copyWith(
                              color: AppColors.placeholderColorDark,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.normalL),
                      Text(
                        '\$ ${car.price}',
                        style: AppTextStyles.zonaPro16.copyWith(color: Colors.green),
                      ),
                    ],
                  ),
                ),
                // Favorite Icon
                Material(
                  borderRadius: BorderRadius.circular(AppDimensions.normalS),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppDimensions.normalS),
                    onTap: () => onDeleteCallback?.call(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.gold.withAlpha(30),
                        borderRadius: BorderRadius.circular(AppDimensions.normalS),
                      ),
                      width: AppDimensions.favoriteButtonSize,
                      height: AppDimensions.favoriteButtonSize,
                      child: const Icon(Icons.favorite, color: AppColors.gold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
