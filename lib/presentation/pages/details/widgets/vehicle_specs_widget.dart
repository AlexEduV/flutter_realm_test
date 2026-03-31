import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/common/extensions/string_extension.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/presentation/bloc/details/details_page_state.dart';
import 'package:test_futter_project/presentation/pages/details/widgets/specification_item/specification_item.dart';
import 'package:test_futter_project/presentation/pages/details/widgets/specification_item/widgets/spec_color_widget.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';

import '../../../../common/app_dimensions.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../l10n/l10n_keys.dart';
import '../../../bloc/details/details_page_cubit.dart';

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
                        turns: state.isVehicleSpecsExpanded ? 0.0 : 0.5, // 0.5 turns = 180 degrees
                        duration: const Duration(milliseconds: 300),
                        child: const Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 28),
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
              return SizedBox(
                width: double.infinity,
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  alignment: AlignmentGeometry.topCenter,
                  curve: Curves.easeInOut,
                  child: state.isVehicleSpecsExpanded
                      ? Padding(
                          padding: const EdgeInsets.only(top: AppDimensions.normalM),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: AppDimensions.normalS,
                                  children: [
                                    SpecificationItem(
                                      title: context.tr(L10nKeys.vehicleSpecificationBody),
                                      subtitle: car.bodyType.capitalizeFirst(),
                                    ),

                                    SpecificationItem(
                                      title: context.tr(L10nKeys.vehicleSpecificationEngine),
                                      subtitle: car.fuelType.capitalizeFirst(),
                                    ),

                                    SpecificationItem(
                                      title: context.tr(L10nKeys.vehicleSpecificationTransmission),
                                      subtitle: car.transmissionType.capitalizeFirst(),
                                    ),
                                  ],
                                ),
                              ),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: AppDimensions.normalS,
                                  children: [
                                    SpecificationItem(
                                      title: context.tr(L10nKeys.vehicleSpecificationMileage),
                                      subtitle:
                                          (car.kilometers ?? context.tr(L10nKeys.unknownLabel))
                                              .toString(),
                                    ),

                                    SpecificationItem(
                                      title: context.tr(L10nKeys.vehicleSpecificationYear),
                                      subtitle: car.year ?? context.tr(L10nKeys.unknownLabel),
                                    ),

                                    SpecificationItem(
                                      title: context.tr(L10nKeys.vehicleSpecificationColor),
                                      subtitle:
                                          car.color?.capitalizeFirst() ??
                                          context.tr(L10nKeys.unknownLabel),
                                      leading: SpecColorWidget(color: car.color),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
