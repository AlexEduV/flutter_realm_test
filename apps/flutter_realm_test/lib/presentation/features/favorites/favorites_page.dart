import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/enums/details_page_source.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/presentation/features/explore/explore_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/favorites/favorites_page_identifiers.dart';
import 'package:test_flutter_project/presentation/features/user/user_data_cubit.dart';
import 'package:test_flutter_project/presentation/features/user/user_data_state.dart';
import 'package:test_flutter_project/presentation/widgets/car_list_item.dart';

import '../explore/explore_page_state.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text(
          context.tr(FavoritesPageLocaleKeys.favoritesPageTitle),
          style: AppTextStyles.zonaPro20,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<UserDataCubit, UserDataState>(
        buildWhen: (previous, current) => previous.user.favoriteIds != current.user.favoriteIds,
        builder: (context, userState) {
          return BlocBuilder<ExplorePageCubit, ExplorePageState>(
            builder: (context, state) {
              final allCars = state.cars;

              final favoriteIds = userState.user.favoriteIds;
              final favoriteEntities = allCars
                  .where((entity) => favoriteIds.contains(entity.carId))
                  .toList();

              if (favoriteEntities.isEmpty) {
                return EmptyResultsPlaceholderWidget(
                  text: context.tr(FavoritesPageLocaleKeys.favoritesEmptyPlaceholder),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.only(top: AppDimensions.normalL),
                itemBuilder: (context, index) {
                  final car = favoriteEntities[index];

                  return CarListItem(
                    car: car,
                    onDeleteCallback: () =>
                        context.read<UserDataCubit>().removeCarIdFromFavorites(car.carId),
                    source: DetailsPageSource.favorites,
                  );
                },
                itemCount: favoriteEntities.length,
              );
            },
          );
        },
      ),
    );
  }
}
