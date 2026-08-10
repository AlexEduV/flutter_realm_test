import 'package:collection/collection.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/enums/details_page_source.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';

import '../../../../../l10n/l10n_keys.dart';
import '../../../../bloc/user/user_data_cubit.dart';
import '../../../../bloc/user/user_data_state.dart';
import '../../../../features/explore/explore_page_cubit.dart';
import '../../../../features/explore/explore_page_state.dart';
import '../../../home/widgets/car_list_item.dart';

class RecentlyViewedPage extends StatelessWidget {
  const RecentlyViewedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text(context.tr(L10nKeys.accountItemViewedItems), style: AppTextStyles.zonaPro20),
        centerTitle: true,
      ),
      body: BlocBuilder<UserDataCubit, UserDataState>(
        buildWhen: (previous, current) => previous.user.viewedIds != current.user.viewedIds,
        builder: (context, userState) {
          return BlocBuilder<ExplorePageCubit, ExplorePageState>(
            builder: (context, state) {
              final allCars = state.cars;

              final viewedIds = userState.user.viewedIds.reversed;

              final viewedEntities = viewedIds
                  .map((id) => allCars.firstWhereOrNull((entity) => entity.carId == id))
                  .whereType<CarEntity>()
                  .toList();

              if (viewedEntities.isEmpty) {
                return EmptyResultsPlaceholderWidget(
                  text: context.tr(L10nKeys.viewedItemsNoResultsPlaceholder),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.only(top: AppDimensions.normalL),
                itemBuilder: (context, index) {
                  final car = viewedEntities[index];

                  return CarListItem(
                    car: car,
                    isFavoriteItem: false,
                    source: DetailsPageSource.recentlyViewed,
                  );
                },
                itemCount: viewedEntities.length,
              );
            },
          );
        },
      ),
    );
  }
}
