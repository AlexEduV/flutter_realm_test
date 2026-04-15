import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/pages/home/widgets/car_list_item.dart';
import 'package:widgetbook/widgetbook.dart';

export '';

Widget buildCarListItemUseCase(BuildContext context) {
  final appLocalisationsCubit = AppLocalisationsCubit()..load({L10nKeys.emptyStateLabel: 'Empty'});

  return Scaffold(
    backgroundColor: AppColors.scaffoldColor,
    body: Padding(
      padding: const EdgeInsets.only(top: AppDimensions.normalM),
      child: MultiBlocProvider(
        providers: [BlocProvider<AppLocalisationsCubit>(create: (_) => appLocalisationsCubit)],
        child: Column(
          spacing: AppDimensions.normalL,
          children: [
            CarListItem(
              car: CarEntity.empty().copyWith(
                model: context.knobs.string(label: 'Model', initialValue: 'Model S'),
                manufacturer: context.knobs.string(label: 'Manufacturer', initialValue: 'Tesla'),
                year: context.knobs.int.input(label: 'Year', initialValue: 2010).toString(),
                price: context.knobs.int.input(label: 'Price', initialValue: 20000),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
