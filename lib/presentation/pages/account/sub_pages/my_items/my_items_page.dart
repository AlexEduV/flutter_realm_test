import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';

import '../../../../../common/app_dimensions.dart';
import '../../../../../common/app_text_styles.dart';
import '../../../../../di/injection_container.dart';
import '../../../../../utils/l10n.dart';
import '../../../../bloc/home/explore_page/explore_page_cubit.dart';
import '../../../../bloc/home/explore_page/explore_page_state.dart';
import '../../../../bloc/user/user_data_cubit.dart';
import '../../../../bloc/user/user_data_state.dart';
import '../../../home/favorites_page/widgets/car_list_item.dart';
import '../../../search/widgets/empty_search_placeholder_widget.dart';

class MyItemsPage extends StatelessWidget {
  const MyItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text(AppLocalisations.accountItemMyItems, style: AppTextStyles.zonaPro20),
        centerTitle: true,
      ),
      body: BlocBuilder<UserDataCubit, UserDataState>(
        buildWhen: (previous, current) => previous.createdIds != current.createdIds,
        builder: (context, state) {
          return BlocBuilder<ExplorePageCubit, ExplorePageState>(
            builder: (context, state) {
              final allCars = state.cars;

              final createdIds = serviceLocator<UserDataCubit>().state.createdIds;
              final createdEntities = allCars
                  .where((entity) => createdIds.contains(entity.carId))
                  .toList();

              if (createdEntities.isEmpty) {
                return EmptyResultsPlaceholderWidget(
                  text: AppLocalisations.myItemsNoResultsPlaceholder,
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.only(top: AppDimensions.normalL),
                itemBuilder: (context, index) {
                  final car = createdEntities[index];

                  return CarListItem(
                    car: car,
                    isFavoriteItem: false,
                    onDeleteCallback: () {
                      context.read<UserDataCubit>().removeCarIdFromCreated(car.carId);
                    },
                  );
                },
                itemCount: createdEntities.length,
              );
            },
          );
        },
      ),
    );
  }
}
