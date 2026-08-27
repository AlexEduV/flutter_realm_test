import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/data/data_sources/local/car_color_local_data_source_impl.dart';
import 'package:test_flutter_project/data/repositories/car_color_repository_impl.dart';
import 'package:test_flutter_project/domain/repositories/car_color_repository.dart';
import 'package:test_flutter_project/presentation/features/color_picker/color_picker_dialog.dart';
import 'package:test_flutter_project/presentation/features/color_picker/color_picker_identifiers.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/features/l10n/l10n_keys.dart';
import 'package:widgetbook/widgetbook.dart';

void _registerCarColorDependencies() {
  if (serviceLocator.isRegistered<CarColorRepository>()) return;
  final repository = CarColorRepositoryImpl(CarColorLocalDataSourceImpl());
  serviceLocator.registerLazySingleton<CarColorRepository>(() => repository);
}

Widget buildColorPickerDialogUseCase(BuildContext context) {
  _registerCarColorDependencies();
  final appLocalisationsCubit = AppLocalisationsCubit()
    ..load({
      L10nKeys.cancelLabel: 'Cancel',
      ColorPickerLocaleKeys.pickColorDialogTitle: 'Pick a Color',
      L10nKeys.confirmLabel: 'Confirm',
    });

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
