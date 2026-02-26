import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, BlocBuilder;
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_routes.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/data/models/scheme.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/usecases/database/delete_car_by_id_use_case.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/presentation/pages/home/explore_page/widgets/explore_article_item.dart';
import 'package:test_futter_project/presentation/pages/home/explore_page/widgets/last_seen_widget.dart';
import 'package:test_futter_project/presentation/widgets/announcement_list_item.dart';
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
          SliverPersistentHeader(
            pinned: true,
            delegate: ExploreHeaderDelegate(
              minHeight: 70, // Height of collapsed app bar
              maxHeight: 350, // Height when fully expanded (adjust as needed)
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

class ExploreHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight; // Height of collapsed app bar
  final double maxHeight; // Height when fully expanded

  ExploreHeaderDelegate({required this.minHeight, required this.maxHeight});

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // Calculate how much the header is collapsed (0.0 = expanded, 1.0 = collapsed)
    final progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    // Interpolate heights for the article list and last seen widget
    final articleHeight = lerpDouble(120, 60, progress)!; // Example values
    final lastSeenOpacity = 1.0 - progress; // Fades out as you scroll

    return Material(
      color: AppColors.headerColor,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(AppDimensions.normalL),
        bottomRight: Radius.circular(AppDimensions.normalL),
      ),
      child: Stack(
        children: [
          // App bar title and search icon
          Positioned(
            left: AppDimensions.normalL,
            right: AppDimensions.normalL,
            top: 12,
            height: minHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalisations.explorePageTitle, style: AppTextStyles.zonaPro30White),
                IconButton(
                  onPressed: () => context.go(AppRoutes.home + AppRoutes.search),
                  icon: const Icon(
                    Icons.search,
                    size: AppDimensions.appBarIconSize,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Horizontal article list
          Positioned(
            left: AppDimensions.normalL,
            right: AppDimensions.normalL,
            top: minHeight,
            height: articleHeight,
            child: Opacity(
              opacity: 1.0,
              child: ListView.separated(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ExploreArticleItem(
                    height: articleHeight,
                    articleName: 'Some Article here',
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: AppDimensions.normalS);
                },
              ),
            ),
          ),
          // Last Seen Widget (fades out as you scroll)
          Positioned(
            top: minHeight + articleHeight + AppDimensions.minorL,
            left: 0,
            right: 0,
            child: Opacity(opacity: lastSeenOpacity, child: const LastSeenWidget()),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant ExploreHeaderDelegate oldDelegate) {
    return minHeight != oldDelegate.minHeight || maxHeight != oldDelegate.maxHeight;
  }
}
