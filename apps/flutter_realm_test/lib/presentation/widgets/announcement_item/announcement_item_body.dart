import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_constants.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_dimensions.dart';
import '../../../common/constants/app_semantics_labels.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/enums/details_page_source.dart';
import '../../../common/extensions/context_extension.dart';
import '../../../domain/entities/car_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../utils/app_router.dart';
import '../../bloc/user/user_data_cubit.dart';
import '../animated_favorite_icon.dart';
import '../app_semantics.dart';
import '../verified_badge.dart';

class AnnouncementItemBody extends StatelessWidget {
  final CarEntity? car;
  final bool isExploreItem;
  final UserEntity? user;

  const AnnouncementItemBody({
    required this.car,
    required this.isExploreItem,
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final carId = car?.carId ?? '';

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppDimensions.normalL),
      child: AppSemantics(
        button: true,
        label: AppSemanticsLabels.announcementListItem,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppDimensions.normalL),
          onTap: () => AppRouter.goToDetails(
            from: isExploreItem ? DetailsPageSource.explore : DetailsPageSource.search,
            carId: carId,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppDimensions.contentPadding,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: AppConstants.aspectRatio,
                    child: Container(
                      decoration: BoxDecoration(
                        color: (car?.images.isEmpty ?? true) ? AppColors.placeholderColor : null,
                        borderRadius: BorderRadius.circular(AppDimensions.normalL),
                        image: (car?.images.isNotEmpty ?? false)
                            ? DecorationImage(
                                image: AssetImage(car?.images.first ?? ''),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                    ),
                  ),

                  Positioned(
                    top: AppDimensions.normalS,
                    right: AppDimensions.normalS,
                    child: Material(
                      borderRadius: BorderRadius.circular(AppDimensions.minorL),
                      color: Colors.white,
                      child: AppSemantics(
                        button: true,
                        label: AppSemanticsLabels.favoriteButton,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(AppDimensions.minorL),
                          onTap: () => onFavoriteButtonTap(context, carId),
                          child: AnimatedFavoriteIcon(
                            size: AppDimensions.favoriteButtonSize,
                            isFavorite: user?.favoriteIds.contains(carId) ?? false,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.normalS),
                child: Row(
                  spacing: AppDimensions.normalXS,
                  children: [
                    Flexible(
                      child: AppSemantics(
                        label: AppSemanticsLabels.announcementTitle,
                        child: Text(
                          '${car?.manufacturer} ${car?.model ?? ''} ${car?.year ?? ''}'
                              .toUpperCase(),
                          style: AppTextStyles.zonaPro24,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),

                    if (car?.isVerified ?? false) ...[const VerifiedBadge()],
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.normalS),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '\$ ${car?.price ?? 0} ',
                            style: AppTextStyles.zonaPro20.copyWith(fontWeight: FontWeight.w400),
                          ),
                          if (car?.promoType != null)
                            getSpanIcon(icon: Icons.whatshot, color: Colors.redAccent),
                        ],
                      ),
                    ),

                    if (user?.isLocationPermissionGranted ?? false) ...[
                      Text.rich(
                        TextSpan(
                          children: [
                            getSpanIcon(icon: Icons.location_pin),
                            TextSpan(
                              text:
                                  '${car?.distanceTo ?? 0} ${context.tr(L10nKeys.distanceWidgetText)}',
                              style: AppTextStyles.zonaPro20.copyWith(fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: AppDimensions.normalS),
            ],
          ),
        ),
      ),
    );
  }

  WidgetSpan getSpanIcon({required IconData icon, Color? color}) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      baseline: TextBaseline.alphabetic,
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppDimensions.minorM),
        child: Icon(icon, size: AppDimensions.normalL, color: color),
      ),
    );
  }

  void onFavoriteButtonTap(BuildContext context, String carId) {
    if (car == null) return;

    if (user?.favoriteIds.contains(carId) ?? false) {
      context.read<UserDataCubit>().removeCarIdFromFavorites(carId);
    } else {
      context.read<UserDataCubit>().addCarIdToFavorites(carId);
    }
  }
}
