import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/common/enums/car_type.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/bloc/home/new_item_page/new_item_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/home/new_item_page/new_item_page_state.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_state.dart';
import 'package:test_flutter_project/presentation/pages/home/new_item_page/sub_pages/car_type_picker.dart';
import 'package:test_flutter_project/presentation/pages/home/new_item_page/widgets/radio_group_title.dart';

import '../../../../../common/extensions/context_extension_test.mocks.dart';
import 'car_type_picker_test.mocks.dart';

@GenerateMocks([NewItemPageCubit])
void main() {
  setUpAll(() {
    // Register fallback value for NewItemPageState if needed
    provideDummy(const NewItemPageState());
  });

  testWidgets('CarTypePicker renders and updates car type on tap', (WidgetTester tester) async {
    // Arrange
    final mockCubit = MockNewItemPageCubit();
    final mockAppLocalisationsCubit = MockAppLocalisationsCubit();
    const state = NewItemPageState(selectedCarType: CarType.bike);

    when(mockCubit.state).thenReturn(state);
    when(mockCubit.updateSelectedCarType(any)).thenReturn(null);
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

    when(mockAppLocalisationsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockAppLocalisationsCubit.state).thenReturn(
      const AppLocalisationsState(
        localisations: {
          L10nKeys.addNewItemTypePickerGroupDescription:
              'What kind of an item are you trying to add?',
          L10nKeys.addNewItemTypePickerGroupItemCar: 'Car',
          L10nKeys.addNewItemTypePickerGroupItemBike: 'Bike',
          L10nKeys.addNewItemTypePickerGroupItemTruck: 'Truck',
        },
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<NewItemPageCubit>.value(value: mockCubit),
            BlocProvider<AppLocalisationsCubit>.value(value: mockAppLocalisationsCubit),
          ],
          child: const Scaffold(body: CarTypePicker()),
        ),
      ),
    );

    // Assert: RadioGroupTitle is present
    expect(find.byType(RadioGroupTitle), findsOneWidget);

    // Assert: ListTiles for car, bike, truck are present
    expect(find.byType(ListTile), findsNWidgets(3));
    expect(find.textContaining('Car'), findsOneWidget);
    expect(find.textContaining('Bike'), findsOneWidget);
    expect(find.textContaining('Truck'), findsOneWidget);

    // Assert: The correct radio is selected (CarType.bike)
    final radioWidgets = tester.widgetList<Radio<CarType>>(find.byType(Radio<CarType>));
    expect(radioWidgets.any((r) => r.value == CarType.bike), isTrue);

    // Act: Tap on the "Car" ListTile
    await tester.tap(find.widgetWithText(ListTile, 'Car'));
    await tester.pump();

    // Assert: updateSelectedCarType is called with CarType.car
    verify(mockCubit.updateSelectedCarType(CarType.car)).called(1);

    // Act: Tap on the "Truck" ListTile
    await tester.tap(find.widgetWithText(ListTile, 'Truck'));
    await tester.pump();

    // Assert: updateSelectedCarType is called with CarType.truck
    verify(mockCubit.updateSelectedCarType(CarType.truck)).called(1);
  });
}
