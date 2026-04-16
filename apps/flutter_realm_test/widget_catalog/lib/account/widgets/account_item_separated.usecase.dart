import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/pages/account/widgets/account_item_separated.dart';
import 'package:widgetbook/widgetbook.dart';

Widget buildAccountItemSeparatedUseCase(BuildContext context) {
  final appLocalisationsCubit = AppLocalisationsCubit()..load({});

  return MultiBlocProvider(
    providers: [BlocProvider<AppLocalisationsCubit>(create: (_) => appLocalisationsCubit)],
    child: Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.normalM),
        child: Column(
          spacing: AppDimensions.normalL,
          children: [
            AccountItemSeparated(
              title: context.knobs.string(label: 'Item name', initialValue: 'Account item'),
              onTap: context.knobs.boolean(label: 'With onTap', initialValue: false) ? () {} : null,
              isEnabled: context.knobs.boolean(label: 'Is enabled', initialValue: true),
            ),
          ],
        ),
      ),
    ),
  );
}
