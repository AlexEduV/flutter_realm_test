import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/pages/messages/widgets/date_divider.dart';
import 'package:widgetbook/widgetbook.dart';

Widget buildMessageDateDividerUseCase(BuildContext context) {
  final appLocalisationsCubit = AppLocalisationsCubit()..load({});

  return MultiBlocProvider(
    providers: [BlocProvider<AppLocalisationsCubit>(create: (_) => appLocalisationsCubit)],
    child: Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.minorL),
        child: Column(
          spacing: AppDimensions.normalL,
          children: [
            DateDivider(
              text: context.knobs.string(label: 'Divider label', initialValue: 'Some Text'),
            ),
          ],
        ),
      ),
    ),
  );
}
