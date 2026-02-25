import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/app_dimensions.dart';
import '../../../../../common/app_semantics_labels.dart';
import '../../../../../common/app_text_styles.dart';
import '../../../../../utils/app_router.dart';
import '../../../../../utils/l10n.dart';
import '../../../../bloc/user/user_data_cubit.dart';
import '../../../../bloc/user/user_data_state.dart';
import '../../../../widgets/app_semantics.dart';

class LastSeenWidget extends StatelessWidget {
  const LastSeenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, userState) {
        final carEntity = userState.lastSeenCar?.entries.first.value;
        if (carEntity == null) {
          return const SizedBox.shrink();
        }

        final image = carEntity.images.firstOrNull;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: AppDimensions.normalL,
                top: AppDimensions.normalL,
              ),
              child: Text(AppLocalisations.lastSeenSectionTitle, style: AppTextStyles.zonaPro18),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: AppDimensions.normalL,
                right: AppDimensions.normalL,
                top: AppDimensions.minorM,
              ),
              child: AppSemantics(
                label: AppSemanticsLabels.lastSeenSectionItem,
                button: true,
                child: InkWell(
                  onTap: () => AppRouter.goToDetailsRouteFromExplore(carEntity.carId),
                  borderRadius: BorderRadius.circular(AppDimensions.normalL),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.headerColor.withAlpha(60),
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

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${carEntity.manufacturer} ${carEntity.model} ${carEntity.year ?? ''}',
                              style: AppTextStyles.zonaPro16White.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text('\$ ${carEntity.price ?? 0}', style: AppTextStyles.zonaPro14White),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
