import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/presentation/pages/details/widgets/specification_item.dart';

import '../../../../common/app_dimensions.dart';
import '../../../../common/app_text_styles.dart';

class VehicleSpecsWidget extends StatefulWidget {
  final CarEntity car;

  const VehicleSpecsWidget({required this.car, super.key});

  @override
  State<VehicleSpecsWidget> createState() => _VehicleSpecsWidgetState();
}

class _VehicleSpecsWidgetState extends State<VehicleSpecsWidget> {
  bool _isExpanded = true;

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
        spacing: AppDimensions.normalM,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Vehicle Specifications',
                style: AppTextStyles.zonaPro20.copyWith(fontWeight: FontWeight.w600),
              ),

              IconButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                icon: AnimatedRotation(
                  turns: _isExpanded ? 0.0 : 0.5, // 0.5 turns = 180 degrees
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 28),
                ),
                style: IconButton.styleFrom(backgroundColor: Colors.white),
                padding: const EdgeInsets.all(AppDimensions.minorXS),
              ),
            ],
          ),

          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: _isExpanded
                ? Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: AppDimensions.normalS,
                          children: [
                            SpecificationItem(title: 'Body', subtitle: widget.car.bodyType),

                            SpecificationItem(title: 'Engine', subtitle: widget.car.fuelType),

                            SpecificationItem(
                              title: 'Transmission',
                              subtitle: widget.car.transmissionType,
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
                              subtitle: widget.car.kilometers.toString(),
                            ),

                            SpecificationItem(title: 'Year', subtitle: widget.car.year ?? ''),

                            SpecificationItem(title: 'Color', subtitle: widget.car.color ?? ''),
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
