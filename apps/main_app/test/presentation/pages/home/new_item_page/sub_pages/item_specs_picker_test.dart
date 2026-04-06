import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/common/enums/body_type.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/fuel_type.dart';
import 'package:test_futter_project/common/enums/transmission_type.dart';
import 'package:test_futter_project/core/di/injection_container.dart';
import 'package:test_futter_project/presentation/bloc/home/new_item_page/new_item_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/new_item_page/new_item_page_state.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_futter_project/presentation/pages/home/new_item_page/sub_pages/item_specs_picker.dart';
import 'package:test_futter_project/presentation/pages/home/new_item_page/widgets/radio_group_title.dart';

import 'car_type_picker_test.mocks.dart';

void main() {
  final mockCubit = MockNewItemPageCubit();
  final appLocalisationsCubit = AppLocalisationsCubit();

  setUpAll(() {
    provideDummy(const NewItemPageState());

    serviceLocator.registerFactory<AppLocalisationsCubit>(() => appLocalisationsCubit);
  });

  tearDownAll(() {
    serviceLocator.unregister<AppLocalisationsCubit>();
  });

  testWidgets('ItemSpecsPicker renders and updates selections on tap', (WidgetTester tester) async {
    // Arrange

    const state = NewItemPageState(
      selectedBodyType: BodyType.minivan,
      selectedFuelType: FuelType.ev,
      selectedTransmissionType: TransmissionType.automatic,
      selectedCarType: CarType.car,
    );

    when(mockCubit.state).thenReturn(state);
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

    when(mockCubit.updateSelectedBodyType(any)).thenReturn(null);
    when(mockCubit.updateSelectedFuelType(any)).thenReturn(null);
    when(mockCubit.updateSelectedTransmissionType(any)).thenReturn(null);

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<NewItemPageCubit>.value(value: mockCubit),
            BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
          ],
          child: const Scaffold(body: ItemSpecsPicker()),
        ),
      ),
    );

    // Assert: RadioGroupTitles are present
    expect(find.byType(RadioGroupTitle), findsNWidgets(3));

    // Assert: ListTiles for body types, fuel types, transmission types are present
    // (You may want to check for specific text if you use localization)
    expect(find.byType(ListTile), findsWidgets);

    // Act: Tap on a body type ListTile
    await tester.tap(find.byType(ListTile).first);
    await tester.pump();
    verify(mockCubit.updateSelectedBodyType(any)).called(2);

    // Act: Tap on a fuel type ListTile
    final fuelTypeTile = find.byWidgetPredicate(
      (widget) =>
          widget is ListTile &&
          widget.title is Text &&
          (widget.title as Text).data?.toLowerCase().contains('diesel') == true,
    );
    if (fuelTypeTile.evaluate().isNotEmpty) {
      await tester.tap(fuelTypeTile);
      await tester.pump();
      verify(mockCubit.updateSelectedFuelType(FuelType.diesel)).called(1);
    }

    // Act: Tap on a transmission type ListTile
    final transmissionTypeTile = find.byWidgetPredicate(
      (widget) =>
          widget is ListTile &&
          widget.title is Text &&
          (widget.title as Text).data?.toLowerCase().contains('manual') == true,
    );
    if (transmissionTypeTile.evaluate().isNotEmpty) {
      await tester.tap(transmissionTypeTile);
      await tester.pump();
      verify(mockCubit.updateSelectedTransmissionType(TransmissionType.manual)).called(1);
    }
  });
}
