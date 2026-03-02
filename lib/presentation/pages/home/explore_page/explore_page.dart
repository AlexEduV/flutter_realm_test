import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, BlocBuilder;
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/data/models/scheme.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/usecases/database/delete_car_by_id_use_case.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/presentation/pages/home/explore_page/widgets/explore_header_delegate.dart';
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, //Android
        statusBarBrightness: Brightness.dark, //iOS
      ),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: CustomScrollView(
          slivers: [
            BlocBuilder<UserDataCubit, UserDataState>(
              builder: (context, state) {
                return SliverPersistentHeader(
                  pinned: true,
                  delegate: ExploreHeaderDelegate(
                    //todo: manual adjustment os size is not good for architecture;
                    minHeight: 100, // Height of collapsed app bar
                    maxHeightWithLastSeen: 260 + AppDimensions.exploreArticleItemBaseSize,
                    maxHeightWithoutLastSeen: 121 + AppDimensions.exploreArticleItemBaseSize,
                    showLastSeen:
                        state.lastSeenCar != null, // Height when fully expanded (adjust as needed)
                  ),
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
                  AppLocalisations.recommendedSectionTitle,
                  style: AppTextStyles.zonaPro18,
                ),
              ),
            ),

            BlocBuilder<ExplorePageCubit, ExplorePageState>(
              builder: (context, state) {
                if (state.isLoading) {
                  //todo: maybe add opacity transition between loading and the list.
                  //and the list items can be shown one at a time.
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
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
