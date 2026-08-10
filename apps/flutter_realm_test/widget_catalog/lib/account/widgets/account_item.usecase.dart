import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/presentation/features/account/account_page_identifiers.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';
import 'package:widgetbook/widgetbook.dart';

Widget buildAccountItemUseCase(BuildContext context) {
  final appLocalisationsCubit = AppLocalisationsCubit()..load({});

  return MultiBlocProvider(
    providers: [BlocProvider<AppLocalisationsCubit>(create: (_) => appLocalisationsCubit)],
    child: Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.only(top: AppDimensions.normalM),
        child: Column(
          spacing: AppDimensions.normalL,
          children: [
            AccountItem(
              label: context.knobs.string(label: 'Item name', initialValue: 'Account item'),
              semanticsId: AccountPageIds.accountItem,
              icon: Icons.settings_input_composite_sharp,
              onTap: context.knobs.boolean(label: 'With onTap', initialValue: false) ? () {} : null,
              isCentered: context.knobs.boolean(label: 'Centered', initialValue: false),
            ),
          ],
        ),
      ),
    ),
  );
}
