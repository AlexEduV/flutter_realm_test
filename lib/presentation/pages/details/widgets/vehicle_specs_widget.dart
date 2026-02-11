import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/presentation/bloc/details/details_page_state.dart';
import 'package:test_futter_project/presentation/pages/details/widgets/specification_item.dart';

import '../../../../common/app_dimensions.dart';
import '../../../../common/app_text_styles.dart';
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
                'Vehicle Specifications',
                style: AppTextStyles.zonaPro20.copyWith(fontWeight: FontWeight.w600),
              ),

              BlocBuilder<DetailsPageCubit, DetailsPageState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () =>
                        context.read<DetailsPageCubit>().expandVehicleSpecsButtonPressed(),
                    icon: AnimatedRotation(
                      turns: state.isVehicleSpecsExpanded ? 0.0 : 0.5, // 0.5 turns = 180 degrees
                      duration: const Duration(milliseconds: 300),
                      child: const Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 28),
                    ),
                    style: IconButton.styleFrom(backgroundColor: Colors.white),
                    padding: const EdgeInsets.all(AppDimensions.minorXS),
                  );
                },
              ),
            ],
          ),

          BlocBuilder<DetailsPageCubit, DetailsPageState>(
            builder: (context, state) {
              return AnimatedSize(
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
                                  SpecificationItem(title: 'Body', subtitle: car.bodyType),

                                  SpecificationItem(title: 'Engine', subtitle: car.fuelType),

                                  SpecificationItem(
                                    title: 'Transmission',
                                    subtitle: car.transmissionType,
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
                                    title: 'Mileage',
                                    subtitle: car.kilometers.toString(),
                                  ),

                                  SpecificationItem(title: 'Year', subtitle: car.year ?? ''),

                                  SpecificationItem(title: 'Color', subtitle: car.color ?? ''),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
    );
  }
}
