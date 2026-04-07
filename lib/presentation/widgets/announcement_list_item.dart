import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart'
    show ActionPane, DrawerMotion, Slidable, SlidableAction, SlidableController;
import 'package:test_futter_project/common/constants/app_colors.dart';
import 'package:test_futter_project/common/constants/app_dimensions.dart';
import 'package:test_futter_project/common/constants/app_semantics_labels.dart';
import 'package:test_futter_project/common/constants/app_text_styles.dart';
import 'package:test_futter_project/common/enums/details_page_source.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/widgets/animated_favorite_icon.dart';
import 'package:test_futter_project/presentation/widgets/verified_badge.dart';

import '../../l10n/l10n_keys.dart';
import '../../utils/app_router.dart';
import 'app_semantics.dart';

class AnnouncementListItem extends StatefulWidget {
  final CarEntity? car;
  final UserEntity? user;
  final void Function()? onDismissed;
  final bool isExploreItem;

  const AnnouncementListItem({
    required this.car,
    required this.user,
    required this.onDismissed,
    this.isExploreItem = true,
    super.key,
  });

  @override
  State<AnnouncementListItem> createState() => _AnnouncementListItemState();
}

class _AnnouncementListItemState extends State<AnnouncementListItem> with TickerProviderStateMixin {
  late final SlidableController slideableController;

  @override
  void initState() {
    super.initState();

    slideableController = SlidableController(this);
  }

  @override
  void dispose() {
    slideableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.normalS),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(AppDimensions.normalL),
        ),
        child: Slidable(
          key: widget.car != null ? ValueKey(widget.car?.carId) : null,
          controller: slideableController,
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            extentRatio: 0.25,
            children: [
              //NOTE: slidable action is not allowed semantics - 'hasSize' exception
              SlidableAction(
                borderRadius: BorderRadius.circular(AppDimensions.normalL),
                onPressed: (context) => widget.onDismissed?.call(),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: context.tr(L10nKeys.deleteButtonTitle),
              ),
            ],
          ),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDimensions.normalL),
            child: AppSemantics(
              button: true,
              label: AppSemanticsLabels.announcementListItem,
              child: InkWell(
                borderRadius: BorderRadius.circular(AppDimensions.normalL),
                onTap: () => widget.isExploreItem
                    ? AppRouter.goToDetails(
                        from: DetailsPageSource.explore,
                        carId: widget.car?.carId ?? '',
                      )
                    : AppRouter.goToDetails(
                        from: DetailsPageSource.search,
                        carId: widget.car?.carId ?? '',
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
                            color: (widget.car?.images.isEmpty ?? true)
                                ? AppColors.placeholderColor
                                : null,
                            borderRadius: BorderRadius.circular(AppDimensions.normalL),
                            image: (widget.car?.images.isNotEmpty ?? false)
                                ? DecorationImage(
                                    image: AssetImage(widget.car?.images.first ?? ''),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                        ),

                        Positioned(
                          top: AppDimensions.normalXS,
                          right: AppDimensions.normalXS,
                          child: Material(
                            borderRadius: BorderRadius.circular(AppDimensions.minorL),
                            color: Colors.white,
                            child: AppSemantics(
                              button: true,
                              label: AppSemanticsLabels.favoriteButton,
                              child: InkWell(
                                onTap: () {
                                  if (widget.car == null) return;

                                  if (widget.user?.favoriteIds.contains(widget.car?.carId) ??
                                      false) {
                                    context.read<UserDataCubit>().removeCarIdFromFavorites(
                                      widget.car!.carId,
                                    );
                                  } else {
                                    context.read<UserDataCubit>().addCarIdToFavorites(
                                      widget.car!.carId,
                                    );
                                  }
                                },
                                child: AnimatedFavoriteIcon(
                                  size: AppDimensions.favoriteButtonSize,
                                  isFavorite:
                                      widget.user?.favoriteIds.contains(widget.car?.carId) ?? false,
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
                                '${widget.car?.manufacturer} ${widget.car?.model ?? ''} ${widget.car?.year ?? ''}'
                                    .toUpperCase(),
                                style: AppTextStyles.zonaPro24,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),

                          if (widget.car?.isVerified ?? false) ...[const VerifiedBadge()],
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
                                  text: '\$ ${widget.car?.price ?? 0} ',
                                  style: AppTextStyles.zonaPro20.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                if (widget.car?.promoType != null)
                                  getSpanIcon(icon: Icons.whatshot, color: Colors.redAccent),
                              ],
                            ),
                          ),

                          if (widget.user?.isLocationPermissionGranted ?? false) ...[
                            Text.rich(
                              TextSpan(
                                children: [
                                  getSpanIcon(icon: Icons.location_pin),
                                  TextSpan(
                                    text:
                                        '${widget.car?.distanceTo ?? 0} ${context.tr(L10nKeys.distanceWidgetText)}',
                                    style: AppTextStyles.zonaPro20.copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
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
