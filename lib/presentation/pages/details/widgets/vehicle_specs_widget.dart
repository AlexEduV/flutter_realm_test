import 'package:flutter/material.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/presentation/pages/details/widgets/specification_item.dart';

import '../../../../common/app_dimensions.dart';
import '../../../../common/app_text_styles.dart';

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
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(AppDimensions.normalS),
      ),
      child: Column(
        spacing: AppDimensions.normalM,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Vehicle Specifications',
                style: AppTextStyles.zonaPro18.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppDimensions.normalS,
                  children: [
                    SpecificationItem(title: 'Body', subtitle: car.bodyType),

                    SpecificationItem(title: 'Engine', subtitle: car.fuelType),

                    SpecificationItem(title: 'Transmission', subtitle: car.transmissionType),
                  ],
                ),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppDimensions.normalS,
                  children: [
                    SpecificationItem(title: 'Mileage', subtitle: car.kilometers.toString()),

                    SpecificationItem(title: 'Year', subtitle: car.year ?? ''),

                    SpecificationItem(title: 'Color', subtitle: car.color ?? ''),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
