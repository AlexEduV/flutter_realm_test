import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter_project/common/constants/api_constants.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/common/constants/app_constants.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/common/constants/app_text_styles.dart';
import 'package:test_flutter_project/presentation/bloc/details/details_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/details/details_page_state.dart';
import 'package:test_flutter_project/presentation/bloc/share/share_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_flutter_project/presentation/pages/details/widgets/owner_widget.dart';
import 'package:test_flutter_project/presentation/pages/details/widgets/vehicle_specs_widget.dart';
import 'package:test_flutter_project/presentation/widgets/animated_favorite_icon.dart';

import '../../../common/constants/app_semantics_labels.dart';
import '../../../core/di/injection_container.dart';
import '../../../domain/models/share_params_model.dart';
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

    context.read<UserDataCubit>().setLastSeenCar(widget.carId);
    context.read<UserDataCubit>().addCarToRecentlyViewed(widget.carId);
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
          Padding(
            padding: const EdgeInsets.only(right: AppDimensions.normalS),
            child: IconButton(
              onPressed: () async {
                final car = context.read<DetailsPageCubit>().state.car;

                await serviceLocator<ShareCubit>().share(
                  ShareParamsModel(
                    title: '${car?.manufacturer} ${car?.model} ${car?.year}',
                    text: '${ApiConstants.webHost}cars/?carId=${car?.carId}',
                  ),
                );
              },
              icon: const AppSemantics(
                button: true,
                label: AppSemanticsLabels.shareButton,
                child: Icon(Icons.ios_share_rounded, size: AppDimensions.appBarIconSize),
              ),
              style: appBarButtonStyle,
            ),
          ),

          BlocBuilder<DetailsPageCubit, DetailsPageState>(
            builder: (context, detailsState) {
              return BlocBuilder<UserDataCubit, UserDataState>(
                builder: (context, userState) {
                  final car = detailsState.car;
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
                          size: AppDimensions.appBarIconSize,
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
          final user = context.read<UserDataCubit>().user;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: AppConstants.aspectRatio,
                  child: Container(
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
                              style: AppTextStyles.zonaPro24.copyWith(fontWeight: FontWeight.w600),
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
                            style: AppTextStyles.zonaPro20.copyWith(fontWeight: FontWeight.w600),
                          ),

                          if (car?.promoType != null) ...[
                            Row(
                              spacing: AppDimensions.minorL,
                              children: [
                                const Icon(
                                  Icons.whatshot,
                                  size: AppDimensions.hotLabelIconSize,
                                  color: Colors.red,
                                ),

                                Text(car?.promoType?.fromLocalisations() ?? ''),
                              ],
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: AppDimensions.minorS),

                      if (car != null) ...[VehicleSpecsWidget(car: car)],

                      const SizedBox(height: AppDimensions.minorL),

                      if (car != null) ...[OwnerWidget(car: car, user: user)],
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
