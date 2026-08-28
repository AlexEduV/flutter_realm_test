import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter_project/common/constants/api_constants.dart';
import 'package:test_flutter_project/common/constants/app_constants.dart';
import 'package:test_flutter_project/presentation/features/details/details_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/details/widgets/owner_widget.dart';
import 'package:test_flutter_project/presentation/features/details/widgets/vehicle_specs/vehicle_specs_widget.dart';
import 'package:test_flutter_project/presentation/features/user/user_data_state.dart';

import '../../../common/constants/app_semantics_labels.dart';
import '../../../domain/models/share_params_model.dart';
import '../../widgets/app_semantics.dart';
import '../share/share_cubit.dart';
import '../user/user_data_cubit.dart';
import 'details_page_state.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({required this.carId, super.key});

  final String carId;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();

    context.read<DetailsPageCubit>().loadData(widget.carId);

    context.read<UserDataCubit>().setLastSeenCar(widget.carId);
    context.read<UserDataCubit>().addCarToRecentlyViewed(widget.carId);
  }

  @override
  Widget build(BuildContext context) {
    final appBarButtonStyle = IconButton.styleFrom(
      backgroundColor: AppColors.white.withAlpha(140),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.normalS)),
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: AppColors.transparent,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: AppSemantics(
            button: true,
            label: MaterialLocalizations.of(context).backButtonTooltip,
            child: const Icon(
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

                await context.read<ShareCubit>().share(
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
                  final isCarFavorite = userState.user.favoriteIds.contains(car?.carId);

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
                          isDecorated: false,
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

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: AppConstants.aspectRatio,
                  child: DecoratedBox(
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
                        spacing: AppDimensions.minorM,
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
                                  color: AppColors.error,
                                ),

                                Text(car?.promoType?.fromLocalisations() ?? ''),
                              ],
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: AppDimensions.minorS),

                      const VehicleSpecsWidget(),

                      const SizedBox(height: AppDimensions.minorL),

                      if (car != null) ...[
                        BlocBuilder<UserDataCubit, UserDataState>(
                          buildWhen: (previous, current) =>
                              previous.user.lastSeenCar != current.user.lastSeenCar ||
                              previous.user.favoriteIds != current.user.favoriteIds ||
                              previous.user.email != current.user.email,
                          builder: (context, state) {
                            return OwnerWidget(car: car, user: state.user);
                          },
                        ),
                      ],
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
