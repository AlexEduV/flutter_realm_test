import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart'
    show ActionPane, DrawerMotion, Slidable, SlidableAction;
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/utils/l10n.dart';

import 'app_semantics.dart';

class AnnouncementListItem extends StatelessWidget {
  final CarEntity? car;
  final UserEntity? user;
  final void Function()? onDismissed;

  const AnnouncementListItem({
    required this.car,
    required this.user,
    required this.onDismissed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteButtonSize = 38.0;

    return AppSemantics(
      label: AppSemanticsLabels.announcementListItem,
      child: Slidable(
        key: car != null ? ValueKey(car?.carId) : null,
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.25,
          children: [
            //slidable action is not allowed semantics - 'hasSize' exception
            SlidableAction(
              onPressed: (context) => onDismissed?.call(),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalisations.deleteButtonTitle,
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(AppDimensions.normalL),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDimensions.normalL),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppDimensions.contentPadding,
            children: [
              Stack(
                children: [
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: AppColors.placeholderColor,
                      borderRadius: BorderRadius.circular(AppDimensions.normalL),
                    ),
                  ),

                  Positioned(
                    top: AppDimensions.normalXS,
                    right: AppDimensions.normalXS,
                    child: Material(
                      borderRadius: BorderRadius.circular(AppDimensions.minorL),
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          if (car == null) return;

                          if (user?.favoriteIds.contains(car?.carId) ?? false) {
                            context.read<UserDataCubit>().removeCarIdFromFavorites(car!.carId);
                          } else {
                            context.read<UserDataCubit>().addCarIdToFavorites(car!.carId);
                          }
                        },
                        child: Container(
                          width: favoriteButtonSize,
                          height: favoriteButtonSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppDimensions.minorL),
                          ),
                          child: Icon(
                            user?.favoriteIds.contains(car?.carId) ?? false
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: AppColors.gold,
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

                    if (car?.isVerified ?? false) ...[
                      Container(
                        padding: const EdgeInsets.all(AppDimensions.minorS),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green[700]),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: AppDimensions.normalXS,
                        ),
                      ),
                    ],
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
                          if (car?.isHotPromotion ?? false)
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
                                  ' ${car?.distanceTo ?? 0} ${AppLocalisations.distanceWidgetText}',
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
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}
