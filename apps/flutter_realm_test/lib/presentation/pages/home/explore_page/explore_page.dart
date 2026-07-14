import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, BlocBuilder;
import 'package:skeletonizer/skeletonizer.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/entities/last_seen_car_entity.dart';
import 'package:test_flutter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_flutter_project/presentation/pages/home/explore_page/widgets/explore_header_delegate.dart';
import 'package:test_flutter_project/presentation/widgets/announcement_item/announcement_list_item.dart';

import '../../../../l10n/l10n_keys.dart';
import '../../../bloc/home/explore_page/explore_page_state.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({required this.scrollController, super.key});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600; // You can adjust this threshold

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, //Android
        statusBarBrightness: Brightness.dark, //iOS
      ),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            BlocBuilder<ExplorePageCubit, ExplorePageState>(
              builder: (context, exploreState) {
                return BlocBuilder<UserDataCubit, UserDataState>(
                  builder: (context, userState) {
                    final showLastSeenWidget = _shouldShowLastSeenWidget(
                      context,
                      userState.lastSeenCar,
                    );

                    return SliverPersistentHeader(
                      pinned: true,
                      delegate: ExploreHeaderDelegate(
                        minHeight:
                            AppDimensions.exploreAppBarBaseSize, // Height of collapsed app bar
                        maxHeightWithLastSeen:
                            AppDimensions.exploreArticleItemBaseSize +
                            AppDimensions.exploreAppBarBaseSize +
                            160,
                        maxHeightWithoutLastSeen:
                            AppDimensions.exploreArticleItemBaseSize +
                            AppDimensions.exploreAppBarBaseSize +
                            21,
                        showLastSeen: showLastSeenWidget,
                        title: context.tr(L10nKeys.explorePageTitle),
                      ),
                    );
                  },
                );
              },
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: AppDimensions.normalL,
                  top: AppDimensions.normalL,
                ),
                child: Text(
                  context.tr(L10nKeys.recommendedSectionTitle),
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
                    buildWhen: (previous, current) => previous.favoriteIds != current.favoriteIds,
                    builder: (context, userState) {
                      Widget buildAnimatedItem(int index) {
                        final car = cars[index];

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
                                          child: _buildItem(car, context),
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
                                  ? const AnnouncementListItem(
                                      car: null,
                                      user: null,
                                      onDismissed: null,
                                    )
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
                                ? const AnnouncementListItem(
                                    car: null,
                                    user: null,
                                    onDismissed: null,
                                  )
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

  Widget _buildItem(CarEntity car, BuildContext context) {
    return AnnouncementListItem(
      user: context.read<UserDataCubit>().user,
      car: car,
      onDismissed: () => _handleDelete(car, context),
    );
  }

  void _handleDelete(CarEntity carToDelete, BuildContext context) {
    final id = carToDelete.carId;
    context.read<ExplorePageCubit>().removeCarById(id);
  }

  bool _shouldShowLastSeenWidget(BuildContext context, LastSeenCarEntity? lastSeenCar) {
    if (lastSeenCar == null) return false;
    return context.read<ExplorePageCubit>().isCarExistsById(lastSeenCar.carId);
  }
}
