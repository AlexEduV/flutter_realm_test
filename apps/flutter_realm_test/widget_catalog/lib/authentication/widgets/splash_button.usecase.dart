import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/pages/authentication/widgets/splash_button.dart';
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
              foregroundColor: Colors.white,
              backgroundColor: AppColors.headerColor,
              isLoading: context.knobs.boolean(label: 'Is loading', initialValue: false),
            ),
          ],
        ),
      ),
    ),
  );
}
