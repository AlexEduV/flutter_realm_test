import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, BlocBuilder;
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/common/constants/app_text_styles.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/data/models/scheme.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/usecases/database/get_car_by_id_use_case.dart';
import 'package:test_flutter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_flutter_project/presentation/pages/home/explore_page/widgets/explore_header_delegate.dart';
import 'package:test_flutter_project/presentation/widgets/announcement_item/announcement_list_item.dart';

import '../../../../common/extensions/car_scheme_extension.dart';
import '../../../../l10n/l10n_keys.dart';
import '../../../bloc/home/explore_page/explore_page_state.dart';

class ExplorePage extends StatelessWidget {
  final ScrollController scrollController;

  const ExplorePage({required this.scrollController, super.key});

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
                    final showLastSeenWidget = getShouldShowLastSeenWidget(userState.lastSeenCar);

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
                if (state.isLoading) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: AnimatedOpacity(
                      opacity: state.isLoading ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 400),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  );
                }

                final cars = state.cars.where((element) => element.isShown == true).toList();
                //todo: animation is not working properly after adding a gridView
                return SliverPadding(
                  padding: const EdgeInsets.only(bottom: AppDimensions.normalXL),
                  sliver: BlocBuilder<UserDataCubit, UserDataState>(
                    buildWhen: (previous, current) => previous.favoriteIds != current.favoriteIds,
                    builder: (context, userState) {
                      return SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final car = cars[index];

                          return Column(
                            children: [
                              TweenAnimationBuilder<double>(
                                tween: Tween(begin: 1, end: !car.isShown ? 0 : 1),
                                duration: const Duration(milliseconds: 300),
                                builder: (context, removalValue, child) {
                                  final hasRemovalAnimationEnded = removalValue == 0;
                                  final curvedRemovalValue = Curves.linearToEaseOut.transform(
                                    removalValue,
                                  );

                                  return TweenAnimationBuilder<double>(
                                    tween: Tween(begin: 0, end: 1),
                                    duration: Duration(milliseconds: 300 + (index * 200)),
                                    builder: (context, value, child) {
                                      return SizedBox(
                                        height: !hasRemovalAnimationEnded ? null : 0,
                                        child: Transform.scale(
                                          alignment: Alignment.topCenter,
                                          scaleY: curvedRemovalValue,
                                          child: Opacity(
                                            opacity: value,
                                            child: Transform.scale(
                                              scale: 0.95 + (0.05 * value),
                                              child: _buildItem(
                                                CarExtensions.fromEntity(car),
                                                context,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          );
                        }, childCount: cars.length),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isTablet ? 2 : 1,
                          childAspectRatio: 16 / 14,
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

  Widget _buildItem(Car car, BuildContext context) {
    return AnnouncementListItem(
      user: context.read<UserDataCubit>().user,
      car: CarEntity.fromSchema(car),
      onDismissed: () => _handleDelete(car, context),
    );
  }

  void _handleDelete(Car carToDelete, BuildContext context) {
    // 1. Capture the data while the object is still valid
    final id = carToDelete.carId;

    // 3. Delete once
    //serviceLocator<DeleteCarByIdUseCase>().call(id);

    context.read<ExplorePageCubit>().removeCarById(id);
  }

  bool getShouldShowLastSeenWidget(Map<DateTime, String>? lastSeenCar) {
    String? carId = lastSeenCar?.values.firstOrNull;
    if (carId != null) {
      final car = serviceLocator<GetCarByIdUseCase>().call(carId);
      if (car.carId == 'testId') carId = null;
    }

    final shouldShowLastSeenWidget = lastSeenCar != null && carId != null;
    return shouldShowLastSeenWidget;
  }
}
