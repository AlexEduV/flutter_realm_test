import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, BlocBuilder;
import 'package:skeletonizer/skeletonizer.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/presentation/features/explore/explore_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/explore/explore_page_identifiers.dart';
import 'package:test_flutter_project/presentation/features/explore/widgets/explore_header_delegate.dart';
import 'package:test_flutter_project/presentation/features/user/user_data_cubit.dart';
import 'package:test_flutter_project/presentation/features/user/user_data_state.dart';
import 'package:test_flutter_project/presentation/widgets/announcement_item/announcement_list_item.dart';

import 'explore_page_state.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({required ScrollController scrollController, super.key})
    : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600; // You can adjust this threshold

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.light, //Android
        statusBarBrightness: Brightness.dark, //iOS
      ),
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            _ExploreHeader(title: context.tr(ExplorePageLocaleKeys.explorePageTitle)),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: AppDimensions.normalL,
                  top: AppDimensions.normalL,
                ),
                child: Text(
                  context.tr(ExplorePageLocaleKeys.recommendedSectionTitle),
                  style: AppTextStyles.zonaPro18,
                ),
              ),
            ),

            BlocBuilder<ExplorePageCubit, ExplorePageState>(
              builder: (context, state) {
                final cars = state.cars;
                return SliverPadding(
                  padding: const EdgeInsets.only(bottom: AppDimensions.normalXL),
                  sliver: BlocBuilder<UserDataCubit, UserDataState>(
                    buildWhen: (previous, current) =>
                        previous.user.favoriteIds != current.user.favoriteIds,
                    builder: (context, userState) {
                      Widget buildAnimatedItem(int index) {
                        final car = cars[index];
                        final user = userState.user;

                        return TweenAnimationBuilder<double>(
                          key: ValueKey(car.carId),
                          tween: Tween(begin: 1, end: car.isShown ? 1 : 0),
                          duration: const Duration(milliseconds: 250),
                          builder: (context, removalValue, child) {
                            final curvedRemoval = Curves.easeInOut.transform(removalValue);

                            return ClipRect(
                              child: Align(
                                alignment: Alignment.topCenter,
                                heightFactor: curvedRemoval,
                                child: Opacity(
                                  opacity: curvedRemoval,
                                  child: TweenAnimationBuilder<double>(
                                    key: ValueKey('entry_${car.carId}'),
                                    tween: Tween(begin: 0.0, end: 1.0),
                                    duration: Duration(milliseconds: 300 + (index * 200)),
                                    builder: (context, value, child) {
                                      return Opacity(
                                        opacity: value,
                                        child: Transform.scale(
                                          scale: 0.95 + (0.05 * value),
                                          child: _buildItem(context, car, user),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }

                      if (!isTablet) {
                        return Skeletonizer.sliver(
                          enabled: state.isLoading,
                          child: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => state.isLoading
                                  ? const AnnouncementListItem(car: null, onDismissed: null)
                                  : buildAnimatedItem(index),
                              childCount: state.isLoading ? 12 : cars.length,
                            ),
                          ),
                        );
                      }

                      return Skeletonizer.sliver(
                        enabled: state.isLoading,
                        child: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => state.isLoading
                                ? const AnnouncementListItem(car: null, onDismissed: null)
                                : buildAnimatedItem(index),
                            childCount: state.isLoading ? 12 : cars.length,
                          ),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 16 / 14,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, CarEntity car, UserEntity? user) {
    return AnnouncementListItem(
      isLocationPermissionGranted: user?.isLocationPermissionGranted ?? false,
      favoriteIds: user?.favoriteIds ?? [],
      car: car,
      onDismissed: () => context.read<ExplorePageCubit>().removeCarById(car.carId),
    );
  }
}

class _ExploreHeader extends StatelessWidget {
  const _ExploreHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExplorePageCubit, ExplorePageState>(
      buildWhen: (prev, curr) => prev.isLoading != curr.isLoading,
      builder: (context, _) {
        return BlocBuilder<UserDataCubit, UserDataState>(
          buildWhen: (prev, curr) => prev.user.lastSeenCar != curr.user.lastSeenCar,
          builder: (context, userState) {
            final showLastSeen = context.read<ExplorePageCubit>().isCarExistsById(
              userState.user.lastSeenCar?.carId,
            );

            return SliverPersistentHeader(
              pinned: true,
              delegate: ExploreHeaderDelegate(
                minHeight: AppDimensions.exploreAppBarBaseSize,
                maxHeightWithLastSeen:
                    AppDimensions.exploreArticleItemBaseSize +
                    AppDimensions.exploreAppBarBaseSize +
                    160,
                maxHeightWithoutLastSeen:
                    AppDimensions.exploreArticleItemBaseSize +
                    AppDimensions.exploreAppBarBaseSize +
                    21,
                showLastSeen: showLastSeen,
                title: title,
              ),
            );
          },
        );
      },
    );
  }
}
