import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/presentation/pages/account/widgets/account_item.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../../../common/constants/app_dimensions.dart';
import '../../../bloc/l10n/app_localisations_cubit.dart';

export '';

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
              text: context.knobs.string(label: 'Item name', initialValue: 'Account item'),
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
