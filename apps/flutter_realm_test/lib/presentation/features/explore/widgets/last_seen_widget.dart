import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/enums/details_page_source.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/presentation/features/explore/explore_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/explore/explore_page_identifiers.dart';

import '../../../../../core/router/app_router.dart';
import '../../../features/user/user_data_state.dart';
import '../../../widgets/app_semantics.dart';
import '../../user/user_data_cubit.dart';
import '../explore_page_state.dart';

class LastSeenWidget extends StatelessWidget {
  const LastSeenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, userState) {
        if (userState.isLoading) {
          return const Center(
            child: CircularProgressIndicator(padding: EdgeInsets.all(AppDimensions.minorL)),
          );
        }

        return BlocBuilder<ExplorePageCubit, ExplorePageState>(
          builder: (context, state) {
            final carId = userState.user.lastSeenCar?.carId;
            final car = context.read<ExplorePageCubit>().getLastSeenCarById(carId);
            final isTestCar = car?.carId == 'testId';

            final image = car?.images.firstOrNull;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppDimensions.normalL,
                    top: AppDimensions.normalL,
                  ),
                  child: Text(
                    context.tr(ExplorePageLocaleKeys.lastSeenSectionTitle),
                    style: AppTextStyles.zonaPro18White.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),

                AppSemantics(
                  label: ExplorePageIds.lastSeenSectionItem,
                  button: true,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: AppDimensions.normalL,
                      right: AppDimensions.normalL,
                      top: AppDimensions.minorM,
                    ),
                    child: Material(
                      color: AppColors.accentColor.withAlpha(60),
                      borderRadius: BorderRadius.circular(AppDimensions.normalL),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          if (car == null) return;

                          AppRouter.goToDetails(from: DetailsPageSource.explore, carId: car.carId);
                        },
                        child: Padding(
                          padding: const EdgeInsetsGeometry.all(AppDimensions.minorM),
                          child: Row(
                            spacing: AppDimensions.minorL,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(AppDimensions.normalXS),
                                  color: image == null ? AppColors.headerColor : null,
                                  image: image != null
                                      ? DecorationImage(image: AssetImage(image), fit: BoxFit.cover)
                                      : null,
                                ),
                                height: AppDimensions.lastSeenSectionImageSize,
                                width: AppDimensions.lastSeenSectionImageSize,
                                margin: const EdgeInsetsGeometry.all(AppDimensions.minorL),
                              ),

                              if (!isTestCar) ...[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${car?.manufacturer} ${car?.model} ${car?.year ?? ''}',
                                      style: AppTextStyles.zonaPro16White.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '\$ ${car?.price ?? 0}',
                                      style: AppTextStyles.zonaPro14White,
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppDimensions.minorL),
              ],
            );
          },
        );
      },
    );
  }
}
