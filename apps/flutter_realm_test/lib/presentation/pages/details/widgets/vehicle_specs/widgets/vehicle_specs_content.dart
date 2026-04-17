import 'package:flutter/material.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';

import '../../../../../../common/constants/app_dimensions.dart';
import '../../../../../../common/extensions/context_extension.dart';
import '../../../../../../common/extensions/string_extension.dart';
import '../../../../../../l10n/l10n_keys.dart';
import '../../specification_item/specification_item.dart';
import '../../specification_item/widgets/spec_color_widget.dart';

class VehicleSpecsContent extends StatelessWidget {
  final CarEntity car;
  final Color? carColor;

  const VehicleSpecsContent({required this.car, required this.carColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  subtitle: (car.mileage ?? context.tr(L10nKeys.unknownLabel)).toString(),
                ),

                SpecificationItem(
                  title: context.tr(L10nKeys.vehicleSpecificationYear),
                  subtitle: car.year ?? context.tr(L10nKeys.unknownLabel),
                ),

                SpecificationItem(
                  title: context.tr(L10nKeys.vehicleSpecificationColor),
                  subtitle: car.color?.capitalizeFirst() ?? context.tr(L10nKeys.unknownLabel),
                  leading: SpecColorWidget(color: carColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
