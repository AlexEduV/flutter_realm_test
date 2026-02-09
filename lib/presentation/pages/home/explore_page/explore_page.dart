import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, BlocBuilder;
import 'package:go_router/go_router.dart';
import 'package:realm/realm.dart';
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
import 'package:test_futter_project/presentation/pages/home/explore_page/widgets/explore_list_item.dart';
import 'package:test_futter_project/presentation/pages/home/explore_page/widgets/explore_section_item.dart';
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
            expandedHeight: 200,
            collapsedHeight: 60,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                // constraints.maxHeight will be between collapsedHeight and expandedHeight
                final currentHeight = constraints.maxHeight;
                // Calculate the item height based on the header's current height
                final itemHeight = (currentHeight - 20).clamp(100.0, 180.0); // Example logic

                return Padding(
                  padding: const EdgeInsets.only(left: AppDimensions.normalL, bottom: 40, top: 120),
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
                  sliver: SliverList(
                    key: cars.isEmpty ? const ValueKey('empty') : widget.listKey,

                    delegate: SliverChildBuilderDelegate((context, index) {
                      final car = cars[index];

                      return _buildItem(CarExtensions.fromEntity(car), index);
                    }, childCount: cars.length),
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
    return ExploreListItem(
      user: context.read<UserDataCubit>().user,
      car: CarEntity.fromSchema(car),
      onDismissed: () => _handleDelete(car, index),
    );
  }

  void _handleDelete(Car carToDelete, int index) {
    // 1. Capture the data while the object is still valid
    final ObjectId id = carToDelete.id;

    // 2. Animate out using a "Snapshot" instance of the same widget
    widget.listKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: const ExploreListItem(car: null, user: null, onDismissed: null),
      ),
      duration: const Duration(milliseconds: 300),
    );

    // 3. Delete once
    serviceLocator<DeleteCarByIdUseCase>().call(id);

    context.read<ExplorePageCubit>().removeCarAt(index);
  }
}
