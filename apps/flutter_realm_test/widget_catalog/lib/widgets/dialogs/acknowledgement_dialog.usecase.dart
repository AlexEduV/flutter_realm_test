import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/acknowledgement_dialog.dart';
import 'package:widgetbook/widgetbook.dart';

Widget buildAcknowledgementDialogUseCase(BuildContext context) {
  final appLocalisationsCubit = AppLocalisationsCubit()..load({});

  return MultiBlocProvider(
    providers: [BlocProvider<AppLocalisationsCubit>(create: (_) => appLocalisationsCubit)],
    child: Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.normalM),
        child: AcknowledgementDialog(
          title: context.knobs.string(label: 'Title', initialValue: 'Dialog'),
          description: context.knobs.string(
            label: 'Description',
            initialValue: 'This is an acknowledgement dialog',
          ),
          confirmButtonTitle: context.knobs.string(
            label: 'Confirm Button Title',
            initialValue: 'Confirm',
          ),
        ),
      ),
    ),
  );
}
