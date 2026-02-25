import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/bloc/details/details_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/details/details_page_state.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/presentation/pages/details/widgets/owner_widget.dart';
import 'package:test_futter_project/presentation/pages/details/widgets/vehicle_specs_widget.dart';
import 'package:test_futter_project/presentation/widgets/animated_favorite_icon.dart';

import '../../../common/app_semantics_labels.dart';
import '../../bloc/user/user_data_cubit.dart';
import '../../widgets/app_semantics.dart';
import '../../widgets/verified_badge.dart';

class DetailsPage extends StatefulWidget {
  final String carId;

  const DetailsPage({required this.carId, super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();

    context.read<DetailsPageCubit>().loadData(widget.carId);
    context.read<DetailsPageCubit>().setVehicleSpecsExpansionState(true);

    //todo: save it to local storage with the date stamp, and remove when the week passes
    final car = context.read<DetailsPageCubit>().state.car;
    context.read<ExplorePageCubit>().setLastSeenCar(car);
  }

  @override
  Widget build(BuildContext context) {
    final appBarButtonStyle = IconButton.styleFrom(
      backgroundColor: Colors.white.withAlpha(140),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.normalS)),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const AppSemantics(
            button: true,
            label: AppSemanticsLabels.backButton,
            child: Icon(
              Icons.arrow_back,
              size: AppDimensions.appBarIconSize,
              color: AppColors.headerColor,
            ),
          ),
          style: appBarButtonStyle,
        ),
        actions: [
          BlocBuilder<UserDataCubit, UserDataState>(
            builder: (context, userState) {
              return BlocBuilder<DetailsPageCubit, DetailsPageState>(
                builder: (context, state) {
                  final car = state.car;
                  final isCarFavorite = userState.favoriteIds.contains(car?.carId);

                  return Padding(
                    padding: const EdgeInsets.only(right: AppDimensions.normalM),
                    child: IconButton(
                      onPressed: () {
                        if (car == null) return;

                        if (isCarFavorite) {
                          context.read<UserDataCubit>().removeCarIdFromFavorites(car.carId);
                        } else {
                          context.read<UserDataCubit>().addCarIdToFavorites(car.carId);
                        }
                      },
                      icon: AppSemantics(
                        button: true,
                        label: AppSemanticsLabels.favoriteButton,
                        child: AnimatedFavoriteIcon(
                          decorated: false,
                          isFavorite: isCarFavorite,
                          size: AppDimensions.favoriteButtonSize,
                        ),
                      ),
                      style: appBarButtonStyle,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<DetailsPageCubit, DetailsPageState>(
        builder: (context, state) {
          final car = state.car;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 280,
                  decoration: BoxDecoration(
                    color: (car?.images.isEmpty ?? true) ? AppColors.placeholderColor : null,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(AppDimensions.majorM),
                      bottomRight: Radius.circular(AppDimensions.majorM),
                    ),
                    image: (car?.images.isNotEmpty ?? false)
                        ? DecorationImage(
                            image: AssetImage(car?.images.first ?? ''),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(AppDimensions.normalM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppDimensions.minorM,
                    children: [
                      Row(
                        spacing: AppDimensions.normalXS,
                        children: [
                          Flexible(
                            child: Text(
                              '${car?.manufacturer ?? ''} ${car?.model ?? ''} ${car?.year ?? ''}',
                              style: AppTextStyles.zonaPro24.copyWith(fontWeight: FontWeight.w500),
                              maxLines: 2,
                            ),
                          ),

                          if (car?.isVerified ?? false) ...[const VerifiedBadge()],
                        ],
                      ),

                      Row(
                        spacing: AppDimensions.normalM,
                        children: [
                          Text(
                            '\$ ${car?.price ?? ''}',
                            style: AppTextStyles.zonaPro18.copyWith(fontWeight: FontWeight.w600),
                          ),

                          if (car?.hotPromotionDescription != null) ...[
                            Row(
                              spacing: AppDimensions.minorL,
                              children: [
                                const Icon(Icons.whatshot, size: 18, color: Colors.red),

                                Text(car?.hotPromotionDescription ?? ''),
                              ],
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: AppDimensions.minorS),

                      if (car != null) ...[VehicleSpecsWidget(car: car)],

                      const SizedBox(height: AppDimensions.minorL),

                      if (car != null) ...[OwnerWidget(car: car)],
                    ],
                  ),
                ),

                const SizedBox(height: AppDimensions.normalL),
              ],
            ),
          );
        },
      ),
    );
  }
}
