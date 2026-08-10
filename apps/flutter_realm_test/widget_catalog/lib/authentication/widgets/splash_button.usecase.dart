import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';
import 'package:widgetbook/widgetbook.dart';

Widget buildSplashButtonUseCase(BuildContext context) {
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
            SplashButton(
              title: context.knobs.string(label: 'Button title', initialValue: 'Splash button'),
              onPressed: () {},
              buttonType: ButtonType.primary,
              isLoading: context.knobs.boolean(label: 'Is loading', initialValue: false),
            ),

            SplashButton(
              title: context.knobs.string(label: 'Button title', initialValue: 'Splash button'),
              onPressed: () {},
              buttonType: ButtonType.secondary,
              isLoading: context.knobs.boolean(label: 'Is loading', initialValue: false),
            ),
          ],
        ),
      ),
    ),
  );
}
