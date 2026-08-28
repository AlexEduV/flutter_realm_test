import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/enums/details_page_source.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';

import '../../../../widgets/car_list_item.dart';
import '../../../explore/explore_page_cubit.dart';
import '../../../explore/explore_page_state.dart';
import '../../../user/user_data_cubit.dart';
import '../../../user/user_data_state.dart';
import '../../account_page_identifiers.dart';

class MyItemsPage extends StatelessWidget {
  const MyItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr(AccountPageLocaleKeys.accountItemMyItems),
          style: AppTextStyles.zonaPro20,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<UserDataCubit, UserDataState>(
        buildWhen: (previous, current) => previous.user.createdIds != current.user.createdIds,
        builder: (context, userState) {
          return BlocBuilder<ExplorePageCubit, ExplorePageState>(
            builder: (context, exploreState) {
              final allCars = exploreState.cars;

              final createdIds = userState.user.createdIds;
              final createdEntities = allCars
                  .where((entity) => createdIds.contains(entity.carId))
                  .toList();

              if (createdEntities.isEmpty) {
                return EmptyResultsPlaceholderWidget(
                  text: context.tr(AccountPageLocaleKeys.myItemsNoResultsPlaceholder),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.only(top: AppDimensions.normalL),
                itemBuilder: (context, index) {
                  final car = createdEntities[index];

                  return CarListItem(
                    car: car,
                    source: DetailsPageSource.myItems,
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
