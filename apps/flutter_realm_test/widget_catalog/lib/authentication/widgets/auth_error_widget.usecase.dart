import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/pages/authentication/widgets/auth_error_widget.dart';
import 'package:widgetbook/widgetbook.dart';

Widget buildAuthErrorWidgetUseCase(BuildContext context) {
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
            AuthErrorWidget(
              text: context.knobs.boolean(label: 'Is error visible', initialValue: true)
                  ? context.knobs.string(label: 'Error text', initialValue: 'Some Auth error')
                  : null,
            ),
          ],
        ),
      ),
    ),
  );
}
