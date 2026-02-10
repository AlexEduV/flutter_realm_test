import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/bloc/details/details_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/details/details_page_state.dart';

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
                      'Toyota Camry',
                      style: AppTextStyles.zonaPro30.copyWith(fontWeight: FontWeight.w500),
                    ),

                    Row(
                      children: [
                        Text(
                          '\$ 20 000',
                          style: AppTextStyles.zonaPro18.copyWith(fontWeight: FontWeight.w600),
                        ),

                        if (car?.isHotPromotion ?? false) ...[
                          const Icon(Icons.whatshot, size: 18, color: Colors.red),
                        ],
                      ],
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
