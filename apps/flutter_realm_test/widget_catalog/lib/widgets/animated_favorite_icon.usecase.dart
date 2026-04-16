import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/widgets/animated_favorite_icon.dart';
import 'package:widgetbook/widgetbook.dart';

export '';

Widget buildAnimatedFavoriteIconUseCase(BuildContext context) {
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
            AnimatedFavoriteIcon(
              isFavorite: context.knobs.boolean(label: 'Is favorite', initialValue: true),
              decorated: context.knobs.boolean(label: 'Is decorated', initialValue: false),
              size: AppDimensions.majorM,
            ),
          ],
        ),
      ),
    ),
  );
}
