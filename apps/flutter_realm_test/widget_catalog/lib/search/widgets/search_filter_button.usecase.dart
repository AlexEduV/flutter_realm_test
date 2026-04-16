import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/pages/search/widgets/search_filter_button.dart';
import 'package:widgetbook/widgetbook.dart';

Widget buildSearchFilterButtonUseCase(BuildContext context) {
  final appLocalisationsCubit = AppLocalisationsCubit()..load({});

  return Scaffold(
    backgroundColor: AppColors.scaffoldColor,
    body: MultiBlocProvider(
      providers: [BlocProvider<AppLocalisationsCubit>(create: (_) => appLocalisationsCubit)],
      child: Column(
        spacing: AppDimensions.normalL,
        children: [
          SearchFilterButton(
            title: context.knobs.string(label: 'Title', initialValue: 'Title'),
            icon: Icons.filter_list_sharp,
            selectionCount: context.knobs.int
                .input(label: 'Count Selected', initialValue: 1)
                .toString(),
            iconSize: context.knobs.double.slider(
              label: 'Icon size',
              initialValue: 40,
              min: 12,
              max: 60,
            ),
            isPlaceHolder: context.knobs.boolean(label: 'Is a placeholder title'),
          ),
        ],
      ),
    ),
  );
}
