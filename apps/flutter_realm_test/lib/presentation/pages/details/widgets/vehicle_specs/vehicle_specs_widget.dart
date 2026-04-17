import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/common/constants/app_semantics_labels.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/common/extensions/num_extension.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/presentation/bloc/details/details_page_state.dart';
import 'package:test_flutter_project/presentation/pages/details/widgets/vehicle_specs/widgets/vehicle_specs_content.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';

import '../../../../../common/constants/app_dimensions.dart';
import '../../../../../common/constants/app_text_styles.dart';
import '../../../../../l10n/l10n_keys.dart';
import '../../../../bloc/details/details_page_cubit.dart';

class VehicleSpecsWidget extends StatelessWidget {
  final CarEntity car;

  const VehicleSpecsWidget({required this.car, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.normalM,
        vertical: AppDimensions.normalL,
      ),
      decoration: BoxDecoration(
        color: AppColors.scaffoldColor,
        borderRadius: BorderRadius.circular(AppDimensions.normalL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.tr(L10nKeys.vehicleSpecificationsSectionTitle),
                style: AppTextStyles.zonaPro20.copyWith(fontWeight: FontWeight.w600),
              ),

              BlocBuilder<DetailsPageCubit, DetailsPageState>(
                buildWhen: (previous, current) =>
                    previous.isLoading != current.isLoading ||
                    previous.isVehicleSpecsExpanded != current.isVehicleSpecsExpanded,
                builder: (context, state) {
                  return AppSemantics(
                    button: true,
                    expanded: state.isVehicleSpecsExpanded,
                    label: AppSemanticsLabels.detailsPageVehicleSpecsExpandButton,
                    child: IconButton(
                      onPressed: () => context
                          .read<DetailsPageCubit>()
                          .setVehicleSpecsExpansionState(!state.isVehicleSpecsExpanded),
                      icon: AnimatedRotation(
                        turns: state.isVehicleSpecsExpanded ? 0.toTurns : 180.toTurns,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                          size: AppDimensions.majorS,
                        ),
                      ),
                      style: IconButton.styleFrom(
                        padding: const EdgeInsets.all(AppDimensions.minorXS),
                        backgroundColor: Colors.white,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      padding: const EdgeInsets.all(AppDimensions.minorXS),
                    ),
                  );
                },
              ),
            ],
          ),

          BlocBuilder<DetailsPageCubit, DetailsPageState>(
            builder: (context, state) {
              final double expandedHeight = 193.0;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: state.isVehicleSpecsExpanded ? expandedHeight : 0,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: VehicleSpecsContent(car: car, carColor: state.carColor),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
