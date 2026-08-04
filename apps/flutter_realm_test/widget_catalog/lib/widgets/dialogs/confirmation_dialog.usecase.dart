import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/confirmation_dialog.dart';
import 'package:widgetbook/widgetbook.dart';

Widget buildConfirmationDialogUseCase(BuildContext context) {
  final appLocalisationsCubit = AppLocalisationsCubit()..load({});

  return MultiBlocProvider(
    providers: [BlocProvider<AppLocalisationsCubit>(create: (_) => appLocalisationsCubit)],
    child: Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.normalM),
        child: ConfirmationDialog(
          title: context.knobs.string(label: 'Title', initialValue: 'Dialog'),
          description: context.knobs.string(
            label: 'Description',
            initialValue: 'This is a confirmation dialog',
          ),
          confirmButtonTitle: context.knobs.string(
            label: 'Confirm Button Title',
            initialValue: 'Confirm',
          ),
          cancelButtonTitle: context.knobs.string(
            label: 'Cancel Button Title',
            initialValue: 'Cancel',
          ),
          isAlertStyling: context.knobs.boolean(label: 'Is Alert?', initialValue: false),
        ),
      ),
    ),
  );
}
