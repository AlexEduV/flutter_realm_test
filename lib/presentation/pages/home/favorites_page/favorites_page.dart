import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_state.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
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
      body: BlocBuilder<ExplorePageCubit, ExplorePageState>(
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

              return Container(
                margin: const EdgeInsets.only(
                  bottom: AppDimensions.normalL,
                  left: AppDimensions.normalL,
                  right: AppDimensions.normalL,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.normalXL),
                  color: Colors.white,
                ),
                child: Container(
                  padding: const EdgeInsets.all(AppDimensions.normalM),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Car Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppDimensions.normalM),
                        child: Container(
                          color: AppColors.placeholderColor,
                          width: AppDimensions.favoriteItemPictureSize,
                          height: AppDimensions.favoriteItemPictureSize,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.normalM),
                      // Car Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${car.manufacturer} ${car.model} ${car.year}',
                              style: AppTextStyles.zonaPro18,
                            ),
                            const SizedBox(height: AppDimensions.minorS),
                            Row(
                              children: [
                                Icon(
                                  Icons.directions_car,
                                  size: AppDimensions.normalM,
                                  color: Colors.grey[700],
                                ),
                                const SizedBox(width: AppDimensions.minorL),
                                Text(
                                  car.bodyType,
                                  style: AppTextStyles.zonaPro14.copyWith(color: Colors.grey[700]),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppDimensions.normalL),
                            Text(
                              '\$ ${car.price}',
                              style: AppTextStyles.zonaPro16.copyWith(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                      // Favorite Icon
                      const SizedBox(
                        width: AppDimensions.favoriteButtonSize,
                        height: AppDimensions.favoriteButtonSize,
                        child: Icon(Icons.favorite, color: AppColors.gold),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: favoriteEntities.length,
          );
        },
      ),
    );
  }
}
