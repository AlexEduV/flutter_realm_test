import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/bloc/details/details_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/details/details_page_state.dart';
import 'package:test_futter_project/presentation/pages/details/widgets/owner_widget.dart';
import 'package:test_futter_project/presentation/pages/details/widgets/vehicle_specs_widget.dart';

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
      backgroundColor: Colors.white,
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
                      borderRadius: BorderRadius.circular(AppDimensions.majorM),
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

                        if (car != null) ...[VehicleSpecsWidget(car: car)],

                        const SizedBox(height: AppDimensions.minorL),

                        if (car != null) ...[OwnerWidget(car: car)],
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
