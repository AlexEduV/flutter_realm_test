import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/common/enums/details_page_source.dart';
import 'package:test_futter_project/common/extensions/string_extension.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/app_dimensions.dart';
import '../../../../../common/app_text_styles.dart';
import '../../../../../common/enums/car_type.dart';
import '../../../../../utils/app_router.dart';

class CarListItem extends StatelessWidget {
  final CarEntity car;
  final Function()? onDeleteCallback;
  final DetailsPageSource source;
  final bool isFavoriteItem;

  const CarListItem({
    required this.car,
    this.onDeleteCallback,
    this.source = DetailsPageSource.explore,
    this.isFavoriteItem = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppDimensions.normalL,
        left: AppDimensions.normalL,
        right: AppDimensions.normalL,
      ),
      child: AppSemantics(
        label: AppSemanticsLabels.favoriteListItem,
        child: Material(
          borderRadius: BorderRadius.circular(AppDimensions.normalXL),
          color: Colors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppDimensions.normalXL),
            onTap: () => routeBySource(source),
            child: Container(
              key: ValueKey(car.carId),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.normalXL),
              ),
              padding: const EdgeInsets.all(AppDimensions.normalM),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Car Image
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimensions.normalM),
                      color: car.images.isEmpty ? AppColors.placeholderColor : null,
                      image: car.images.isNotEmpty
                          ? DecorationImage(image: AssetImage(car.images.first), fit: BoxFit.cover)
                          : null,
                    ),
                    height: AppDimensions.favoriteItemPictureSize,
                    width: AppDimensions.favoriteItemPictureSize,
                  ),
                  const SizedBox(width: AppDimensions.normalM),
                  // Car Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${car.manufacturer} ${car.model} ${car.year ?? ''}',
                          style: AppTextStyles.zonaPro18,
                        ),
                        const SizedBox(height: AppDimensions.minorS),
                        Row(
                          children: [
                            Icon(
                              getIconByCarType(car.type),
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
                  if (onDeleteCallback != null) ...[
                    AppSemantics(
                      button: true,
                      label: AppSemanticsLabels.favoriteButton,
                      child: Material(
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
                            child: isFavoriteItem
                                ? const Icon(Icons.favorite, color: AppColors.gold)
                                : const Icon(Icons.remove_circle, color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData getIconByCarType(String type) {
    final iconMap = {
      CarType.truck.name: Icons.local_shipping_outlined,
      CarType.bike.name: Icons.motorcycle_outlined,
      CarType.car.name: Icons.directions_car_outlined,
    };

    return iconMap[type] ?? Icons.directions_car_outlined;
  }

  //todo: probably needs rework, including the app_router
  void routeBySource(DetailsPageSource source) {
    if (source == DetailsPageSource.myItems) {
      return AppRouter.goToDetailsFromAccountMyItems(car.carId);
    } else if (source == DetailsPageSource.recentlyViewed) {
      return AppRouter.goToDetailsFromAccountRecentItems(car.carId);
    }

    return AppRouter.goToDetailsRouteFromExplore(car.carId);
  }
}
