import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_project/common/constants/app_semantics_labels.dart';
import 'package:test_flutter_project/common/enums/details_page_source.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/common/extensions/string_extension.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/presentation/features/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';

import '../../common/enums/car_type.dart';
import '../../core/router/app_router.dart';

class CarListItem extends StatelessWidget {
  const CarListItem({
    required this.car,
    this.onDeleteCallback,
    this.source = DetailsPageSource.explore,
    super.key,
  });

  final CarEntity car;
  final void Function()? onDeleteCallback;
  final DetailsPageSource source;

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
        color: AppColors.white,
        child: AppSemantics(
          label: '${AppSemanticsLabels.carListItem} ${source.name}',
          child: InkWell(
            borderRadius: BorderRadius.circular(AppDimensions.normalXL),
            onTap: () => AppRouter.goToDetails(from: source, carId: car.carId),
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
                    width: AppDimensions.favoriteItemPictureSize * 1.4,
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
                              _getIconByCarType(car.type),
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
                          '\$ ${car.price ?? context.tr(L10nKeys.emptyStateLabel)}',
                          style: AppTextStyles.zonaPro16.copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.w600,
                          ),
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
                            child: source == DetailsPageSource.favorites
                                ? const Icon(Icons.favorite, color: AppColors.gold)
                                : const Icon(Icons.remove_circle, color: AppColors.error),
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

  IconData _getIconByCarType(String type) {
    final iconMap = {
      CarType.truck.name: Icons.local_shipping_outlined,
      CarType.bike.name: Icons.motorcycle_outlined,
      CarType.car.name: Icons.directions_car_outlined,
    };

    return iconMap[type] ?? Icons.directions_car_outlined;
  }
}
