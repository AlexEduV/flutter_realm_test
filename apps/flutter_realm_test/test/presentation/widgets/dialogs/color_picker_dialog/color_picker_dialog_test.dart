import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/domain/usecases/car_colors/get_car_color_by_name_use_case.dart';
import 'package:test_flutter_project/domain/usecases/car_colors/get_car_color_name_from_color_use_case.dart';
import 'package:test_flutter_project/domain/usecases/car_colors/get_car_colors_use_case.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/color_picker_dialog/color_item.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/color_picker_dialog/color_picker_dialog.dart';

import '../../../pages/details/widgets/vehicle_specs_widget_test.mocks.dart';
import 'color_picker_dialog_test.mocks.dart';

@GenerateMocks([GetCarColorByNameUseCase, GetCarColorNameFromColorUseCase])
void main() {
  final appLocalisationsCubit = AppLocalisationsCubit();
  appLocalisationsCubit.load({
    L10nKeys.pickColorDialogTitle: 'Pick a color',
    L10nKeys.cancelLabel: 'Cancel',
    L10nKeys.confirmLabel: 'Confirm',
  });

  setUp(() {
    // Register a mock for the service locator
    final mockGetCarColorsUseCase = MockGetCarColorsUseCase();
    final mockGetCarColorByNameUseCase = MockGetCarColorByNameUseCase();
    final mockGetCarColorNameFromColorUseCase = MockGetCarColorNameFromColorUseCase();

    when(
      mockGetCarColorsUseCase.call(),
    ).thenReturn({'red': Colors.red, 'blue': Colors.blue, 'green': Colors.green});

    when(mockGetCarColorByNameUseCase.call('blue')).thenReturn(Colors.blue);
    when(mockGetCarColorByNameUseCase.call('green')).thenReturn(Colors.green);
    when(mockGetCarColorNameFromColorUseCase.call(any)).thenReturn('Red');

    serviceLocator.registerSingleton<GetCarColorsUseCase>(mockGetCarColorsUseCase);
    serviceLocator.registerSingleton<GetCarColorNameFromColorUseCase>(
      mockGetCarColorNameFromColorUseCase,
    );
    serviceLocator.registerSingleton<GetCarColorByNameUseCase>(mockGetCarColorByNameUseCase);
  });

  tearDown(() {
    serviceLocator.unregister<GetCarColorsUseCase>();
    serviceLocator.unregister<GetCarColorByNameUseCase>();
    serviceLocator.unregister<GetCarColorNameFromColorUseCase>();
  });

  testWidgets('ColorPickerDialog renders colors and handles selection', (
    WidgetTester tester,
  ) async {
    // Arrange
    String? result;
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit)],
        child: MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () async {
                  result = await showDialog<String>(
                    context: context,
                    builder: (_) => const ColorPickerDialog(initialColor: 'blue'),
                  );
                },
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      ),
    );

    // Open the dialog
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    // Assert: All ColorItems are present
    expect(find.byType(ColorItem), findsNWidgets(3));

    // Assert: The correct color is initially picked (blue)
    final colorItems = tester.widgetList<ColorItem>(find.byType(ColorItem));
    expect(colorItems.any((item) => item.color == Colors.blue && item.isPicked), isTrue);

    // Act: Tap the red ColorItem
    await tester.tap(
      find.byWidgetPredicate((widget) => widget is ColorItem && widget.color == Colors.red),
    );
    await tester.pump();

    // Assert: The picked color is now red
    final updatedColorItems = tester.widgetList<ColorItem>(find.byType(ColorItem));
    expect(updatedColorItems.any((item) => item.color == Colors.red && item.isPicked), isTrue);

    // Act: Tap Confirm
    await tester.tap(find.widgetWithText(ElevatedButton, 'Confirm'));
    await tester.pumpAndSettle();

    // Assert: The dialog returns 'Red'
    expect(result, 'Red');
  });

  testWidgets('ColorPickerDialog pops with initial color on cancel', (WidgetTester tester) async {
    String? result;
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit)],
        child: MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () async {
                  result = await showDialog<String>(
                    context: context,
                    builder: (_) => const ColorPickerDialog(initialColor: 'green'),
                  );
                },
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      ),
    );

    // Open the dialog
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    // Act: Tap Cancel
    await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
    await tester.pumpAndSettle();

    // Assert: The dialog returns the initial color
    expect(result, 'green');
  });
}
