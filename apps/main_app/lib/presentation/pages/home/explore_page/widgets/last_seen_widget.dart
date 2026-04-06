import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/enums/details_page_source.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_state.dart';

import '../../../../../common/constants/app_colors.dart';
import '../../../../../common/constants/app_dimensions.dart';
import '../../../../../common/constants/app_semantics_labels.dart';
import '../../../../../common/constants/app_text_styles.dart';
import '../../../../../core/di/injection_container.dart';
import '../../../../../domain/usecases/database/get_car_by_id_use_case.dart';
import '../../../../../l10n/l10n_keys.dart';
import '../../../../../utils/app_router.dart';
import '../../../../bloc/user/user_data_cubit.dart';
import '../../../../bloc/user/user_data_state.dart';
import '../../../../widgets/app_semantics.dart';

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
            final carId = userState.lastSeenCar?.entries.first.value;
            final carEntityFull = serviceLocator<GetCarByIdUseCase>().call(carId ?? '');
            final isTestCar = carEntityFull.carId == 'testId';

            final image = carEntityFull.images.firstOrNull;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppDimensions.normalL,
                    top: AppDimensions.normalL,
                  ),
                  child: Text(
                    context.tr(L10nKeys.lastSeenSectionTitle),
                    style: AppTextStyles.zonaPro18White.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),

                AppSemantics(
                  label: AppSemanticsLabels.lastSeenSectionItem,
                  button: true,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: AppDimensions.normalL,
                      right: AppDimensions.normalL,
                      top: AppDimensions.minorM,
                    ),
                    child: InkWell(
                      onTap: () => AppRouter.goToDetails(
                        from: DetailsPageSource.explore,
                        carId: carEntityFull.carId,
                      ),
                      borderRadius: BorderRadius.circular(AppDimensions.normalL),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.accentColor.withAlpha(60),
                          borderRadius: BorderRadius.circular(AppDimensions.normalL),
                        ),
                        padding: const EdgeInsetsGeometry.all(AppDimensions.minorM),
                        child: Row(
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

                            const SizedBox(width: AppDimensions.minorL),

                            if (!isTestCar) ...[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${carEntityFull.manufacturer} ${carEntityFull.model} ${carEntityFull.year ?? ''}',
                                    style: AppTextStyles.zonaPro16White.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '\$ ${carEntityFull.price ?? 0}',
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

                const SizedBox(height: AppDimensions.minorL),
              ],
            );
          },
        );
      },
    );
  }
}
