import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, BlocBuilder;
import 'package:go_router/go_router.dart';
import 'package:realm/realm.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_routes.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/data/models/scheme.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/repositories/car_repository.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page_cubit.dart';
import 'package:test_futter_project/presentation/pages/home/widgets/explore_list_item.dart';
import 'package:test_futter_project/presentation/pages/home/widgets/explore_section_item.dart';
import 'package:test_futter_project/utils/l10n.dart';

import '../../../common/extensions/car_scheme_extension.dart';
import '../../bloc/home/explore_page_state.dart';

class ExplorePageTest extends StatefulWidget {
  const ExplorePageTest({super.key});

  @override
  State<ExplorePageTest> createState() => _ExplorePageTestState();
}

class _ExplorePageTestState extends State<ExplorePageTest> with WidgetsBindingObserver {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.headerColor,
            title: Text(AppLocalisations.explorePageTitle, style: AppTextStyles.zonaPro30White),
            actions: [
              IconButton(
                onPressed: () {
                  context.go(AppRoutes.home + AppRoutes.search);
                },
                icon: const Icon(
                  Icons.search,
                  size: AppDimensions.appBarIconSize,
                  color: Colors.white,
                ),
              ),
            ],
            actionsPadding: const EdgeInsets.only(right: AppDimensions.normalL),
            expandedHeight: 200,
            collapsedHeight: 60,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                // constraints.maxHeight will be between collapsedHeight and expandedHeight
                final currentHeight = constraints.maxHeight;
                // Calculate the item height based on the header's current height
                final itemHeight = (currentHeight - 20).clamp(100.0, 180.0); // Example logic

                return Container(
                  padding: const EdgeInsets.only(left: AppDimensions.normalL, bottom: 40, top: 110),
                  decoration: const BoxDecoration(
                    color: AppColors.headerColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(AppDimensions.normalL),
                      bottomRight: Radius.circular(AppDimensions.normalL),
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: AppDimensions.normalXL,
                      children: [
                        ExploreSectionItem(height: itemHeight),
                        ExploreSectionItem(height: itemHeight),
                        ExploreSectionItem(height: itemHeight),
                        const SizedBox.shrink(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: AppDimensions.normalL, top: AppDimensions.normalL),
              child: Text(AppLocalisations.recommendedSectionTitle, style: AppTextStyles.zonaPro18),
            ),
          ),

          BlocBuilder<ExplorePageCubit, ExplorePageState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
              } else {
                return SliverList(
                  key: state.cars.isEmpty ? const ValueKey('empty') : _listKey,

                  delegate: SliverChildBuilderDelegate((context, index) {
                    final car = state.cars[index];

                    return _buildItem(CarExtensions.fromEntity(car), index);
                  }, childCount: state.cars.length),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCarToBase,
        tooltip: AppLocalisations.addCarButtonTooltip,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addCarToBase() {
    serviceLocator<CarRepository>().addCar(
      CarEntity(
        carId: '3',
        model: 'Model Y',
        manufacturer: 'Tesla',
        isVerified: false,
        isHotPromotion: false,
        type: 'car',
      ),
    );
    final cars = serviceLocator<CarRepository>().getAllCars();

    _listKey.currentState?.insertItem(cars.length - 1);
    context.read<ExplorePageCubit>().updateCars(cars);
  }

  Widget _buildItem(Car car, int index) {
    return ExploreListItem(
      car: CarEntity.fromSchema(car),
      onDismissed: () => _handleDelete(car, index),
    );
  }

  void _handleDelete(Car carToDelete, int index) {
    // 1. Capture the data while the object is still valid
    final ObjectId id = carToDelete.id;

    // 2. Animate out using a "Snapshot" instance of the same widget
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: const ExploreListItem(car: null, onDismissed: null),
      ),
      duration: const Duration(milliseconds: 300),
    );

    // 3. Delete once
    serviceLocator<CarRepository>().deleteCarById(id);

    context.read<ExplorePageCubit>().removeCarAt(index);
  }
}
