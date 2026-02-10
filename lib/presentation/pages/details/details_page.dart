import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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

          return Stack(
            children: [
              Positioned(
                top: 55,
                left: 0,
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(
                    Icons.arrow_back,
                    size: AppDimensions.appBarIconSize,
                    color: AppColors.headerColor,
                  ),
                ),
              ),

              Column(
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
                                        SpecificationItem(
                                          title: 'Body',
                                          subtitle: car?.bodyType ?? '',
                                        ),

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

                                        SpecificationItem(
                                          title: 'Color',
                                          subtitle: car?.color ?? '',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: AppDimensions.minorL),

                        Container(
                          padding: const EdgeInsets.all(AppDimensions.normalS),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(AppDimensions.normalS),
                          ),
                          child: Column(
                            children: [
                              Row(
                                spacing: AppDimensions.normalM,
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: AppColors.scaffoldColor,
                                    radius: 24,
                                  ),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          car?.owner ?? '',
                                          style: AppTextStyles.zonaPro18.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Owner',
                                              style: AppTextStyles.zonaPro16Grey.copyWith(
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),

                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.location_pin,
                                                  size: AppDimensions.detailsPageItemIconSize,
                                                  color: Colors.grey,
                                                ),

                                                Text(
                                                  '${car?.distanceTo ?? ''} km away',
                                                  style: AppTextStyles.zonaPro16Grey.copyWith(
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: AppDimensions.normalM),

                              SizedBox(
                                width: double.infinity, // Makes the button full width
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Your action here
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ), // Button height
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        8,
                                      ), // Optional rounded corners
                                    ),
                                    // You can customize splash color via overlayColor
                                  ),
                                  child: const Text(
                                    'Send Message',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ].reversed.toList(),
          );
        },
      ),
    );
  }
}
