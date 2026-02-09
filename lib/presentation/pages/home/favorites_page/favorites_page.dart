import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_state.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/presentation/pages/home/favorites_page/widgets/favorites_list_item.dart';
import 'package:test_futter_project/utils/l10n.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text(AppLocalisations.favoritesPageTitle, style: AppTextStyles.zonaPro30),
        backgroundColor: AppColors.scaffoldColor,
      ),
      body: BlocBuilder<UserDataCubit, UserDataState>(
        buildWhen: (previous, current) => previous.favoriteIds != current.favoriteIds,
        builder: (context, state) {
          return BlocBuilder<ExplorePageCubit, ExplorePageState>(
            builder: (context, state) {
              final allCars = state.cars;

              final favoriteIds = context.read<UserDataCubit>().state.favoriteIds;
              final favoriteEntities = allCars
                  .where((entity) => favoriteIds.contains(entity.carId))
                  .toList();

              return ListView.builder(
                padding: const EdgeInsets.only(top: AppDimensions.normalL),
                itemBuilder: (context, index) {
                  final car = favoriteEntities[index];

                  return FavoritesListItem(
                    car: car,
                    onDeleteCallback: () =>
                        context.read<UserDataCubit>().removeCarIdFromFavorites(car.carId),
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
