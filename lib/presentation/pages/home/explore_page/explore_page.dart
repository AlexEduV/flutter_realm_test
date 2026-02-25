import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, BlocBuilder;
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_routes.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/data/models/scheme.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/usecases/database/delete_car_by_id_use_case.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/presentation/pages/home/explore_page/widgets/explore_section_item.dart';
import 'package:test_futter_project/presentation/widgets/announcement_list_item.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';
import 'package:test_futter_project/utils/l10n.dart';

import '../../../../common/extensions/car_scheme_extension.dart';
import '../../../bloc/home/explore_page/explore_page_state.dart';

class ExplorePage extends StatefulWidget {
  final GlobalKey<AnimatedListState> listKey;

  const ExplorePage({required this.listKey, super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.headerColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppDimensions.normalL),
                bottomRight: Radius.circular(AppDimensions.normalL),
              ),
            ),
            title: Text(AppLocalisations.explorePageTitle, style: AppTextStyles.zonaPro30White),
            actions: [
              AppSemantics(
                label: AppSemanticsLabels.homePageSearchButton,
                button: true,
                child: IconButton(
                  onPressed: () => context.go(AppRoutes.home + AppRoutes.search),
                  icon: const Icon(
                    Icons.search,
                    size: AppDimensions.appBarIconSize,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
            actionsPadding: const EdgeInsets.only(right: AppDimensions.normalL),
            expandedHeight: 220,
            collapsedHeight: 60,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                // constraints.maxHeight will be between collapsedHeight and expandedHeight
                final currentHeight = constraints.maxHeight;
                // Calculate the item height based on the header's current height
                final itemHeight = (currentHeight - 20).clamp(100.0, 180.0); // Example logic

                return Padding(
                  padding: const EdgeInsets.only(left: AppDimensions.normalL, bottom: 30, top: 100),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: AppDimensions.normalXL,
                      children: [
                        ExploreSectionItem(height: itemHeight, articleName: 'Some Article here'),
                        ExploreSectionItem(height: itemHeight, articleName: 'Another one'),
                        ExploreSectionItem(height: itemHeight, articleName: 'And another one'),
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
              child: Text('Last seen', style: AppTextStyles.zonaPro18),
            ),
          ),

          SliverToBoxAdapter(
            child: BlocBuilder<ExplorePageCubit, ExplorePageState>(
              builder: (context, state) {
                final car = context.read<UserDataCubit>().state.lastSeenCar?.entries.first.value;
                if (car == null) return const SizedBox.shrink();

                return Padding(
                  padding: const EdgeInsets.only(
                    left: AppDimensions.normalL,
                    right: AppDimensions.normalL,
                    top: AppDimensions.minorM,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.headerColor.withAlpha(60),
                      borderRadius: BorderRadius.circular(AppDimensions.normalL),
                    ),
                    padding: const EdgeInsetsGeometry.all(AppDimensions.minorM),
                    child: Row(
                      spacing: AppDimensions.normalM,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppDimensions.normalM),
                            color: AppColors.headerColor,
                          ),
                          height: 60,
                          width: 60,
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${car.manufacturer} ${car.model} ${car.year ?? ''}',
                              style: AppTextStyles.zonaPro16White.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text('\$ ${car.price ?? 0}', style: AppTextStyles.zonaPro14White),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppDimensions.normalL,
                top: AppDimensions.normalL,
              ),
              child: Text(AppLocalisations.recommendedSectionTitle, style: AppTextStyles.zonaPro18),
            ),
          ),

          BlocBuilder<ExplorePageCubit, ExplorePageState>(
            builder: (context, state) {
              if (state.isLoading) {
                //todo: maybe add opacity transition between loading and the list.
                //and the list items can be shown one at a time.
                return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
              } else {
                final cars = state.cars;

                return SliverPadding(
                  padding: const EdgeInsets.only(bottom: AppDimensions.normalXL),
                  sliver: BlocBuilder<UserDataCubit, UserDataState>(
                    buildWhen: (previous, current) => previous.favoriteIds != current.favoriteIds,
                    builder: (context, state) {
                      return SliverList(
                        key: cars.isEmpty ? const ValueKey('empty') : widget.listKey,
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final car = cars[index];

                          return _buildItem(CarExtensions.fromEntity(car), index);
                        }, childCount: cars.length),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItem(Car car, int index) {
    return AnnouncementListItem(
      user: context.read<UserDataCubit>().user,
      car: CarEntity.fromSchema(car),
      onDismissed: () => _handleDelete(car, index),
    );
  }

  void _handleDelete(Car carToDelete, int index) {
    // 1. Capture the data while the object is still valid
    final id = carToDelete.carId;

    // 2. Animate out using a "Snapshot" instance of the same widget
    widget.listKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: const AnnouncementListItem(car: null, user: null, onDismissed: null),
      ),
      duration: const Duration(milliseconds: 300),
    );

    // 3. Delete once
    serviceLocator<DeleteCarByIdUseCase>().call(id);

    context.read<ExplorePageCubit>().removeCarAt(index);
  }
}
