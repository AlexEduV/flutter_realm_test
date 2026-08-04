import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/color_picker_dialog/color_picker_dialog.dart';
import 'package:widgetbook/widgetbook.dart';

Widget buildColorPickerDialogUseCase(BuildContext context) {
  final appLocalisationsCubit = AppLocalisationsCubit()..load({});

  return MultiBlocProvider(
    providers: [BlocProvider<AppLocalisationsCubit>(create: (_) => appLocalisationsCubit)],
    child: Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.normalM),
        child: ColorPickerDialog(
          initialColor: context.knobs.string(label: 'Initial Color Label', initialValue: 'White'),
        ),
      ),
    ),
  );
}
