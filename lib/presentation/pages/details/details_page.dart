import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/bloc/details/details_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/details/details_page_state.dart';
import 'package:test_futter_project/presentation/pages/details/widgets/specification_item.dart';

class DetailsPage extends StatefulWidget {
  final String carId;

  const DetailsPage({required this.carId, super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();

    context.read<DetailsPageCubit>().loadData(widget.carId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: BlocBuilder<DetailsPageCubit, DetailsPageState>(
        builder: (context, state) {
          final car = state.car;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 280,
                decoration: BoxDecoration(
                  color: AppColors.placeholderColor,
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(AppDimensions.normalM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppDimensions.minorM,
                  children: [
                    Text(
                      '${car?.manufacturer ?? ''} ${car?.model ?? ''} ${car?.year ?? ''}',
                      style: AppTextStyles.zonaPro24.copyWith(fontWeight: FontWeight.w500),
                    ),

                    Row(
                      children: [
                        Text(
                          '\$ ${car?.price ?? ''}',
                          style: AppTextStyles.zonaPro18.copyWith(fontWeight: FontWeight.w600),
                        ),

                        if (car?.isHotPromotion ?? false) ...[
                          const Icon(Icons.whatshot, size: 18, color: Colors.red),
                        ],
                      ],
                    ),

                    const SizedBox(height: AppDimensions.minorS),

                    Container(
                      padding: const EdgeInsets.all(AppDimensions.normalS),
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
                                style: AppTextStyles.zonaPro18.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
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
                                    SpecificationItem(title: 'Body', subtitle: car?.bodyType ?? ''),

                                    SpecificationItem(
                                      title: 'Engine',
                                      subtitle: car?.fuelType ?? '',
                                    ),

                                    SpecificationItem(
                                      title: 'Transmission',
                                      subtitle: car?.transmissionType ?? '',
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
                                      subtitle: car?.kilometers.toString() ?? '',
                                    ),

                                    SpecificationItem(title: 'Year', subtitle: car?.year ?? ''),

                                    SpecificationItem(title: 'Color', subtitle: car?.color ?? ''),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
