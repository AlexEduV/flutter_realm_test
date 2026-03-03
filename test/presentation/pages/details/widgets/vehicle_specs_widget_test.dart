import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/presentation/bloc/details/details_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/details/details_page_state.dart';
import 'package:test_futter_project/presentation/pages/details/widgets/vehicle_specs_widget.dart';
import 'package:test_futter_project/utils/l10n.dart';

import '../../../../utils/app_router_test.mocks.dart';

void main() {
  setUp(() {
    AppLocalisations.localisations = {
      'pages.vehicleDetails.sectionTitle': 'Vehicle Details',
      'pages.vehicleDetails.specifications.body': 'Body',
      'pages.vehicleDetails.specifications.engine': 'Engine',
      'pages.vehicleDetails.specifications.transmission': 'Transmission',
      'pages.vehicleDetails.specifications.mileage': 'Mileage',
      'pages.vehicleDetails.specifications.color': 'Color',
      'pages.vehicleDetails.specifications.year': 'Year',
    };
  });

  CarEntity testCar = CarEntity(
    carId: '1',
    model: 'Model S',
    manufacturer: 'Tesla',
    isVerified: true,
    type: 'Car',
    bodyType: 'sedan',
    fuelType: 'electric',
    transmissionType: 'automatic',
    kilometers: 12345,
    year: '2022',
    color: 'red',
  );

  testWidgets('displays section title and expand button', (tester) async {
    final cubit = MockDetailsPageCubit();
    when(cubit.stream).thenAnswer((_) => const Stream.empty());
    when(cubit.state).thenReturn(const DetailsPageState());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<DetailsPageCubit>(
          create: (_) => cubit,
          child: VehicleSpecsWidget(car: testCar),
        ),
      ),
    );

    expect(find.text('Vehicle Details'), findsOneWidget);
    expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
  });

  testWidgets('expands and shows specifications when button is pressed', (tester) async {
    final cubit = MockDetailsPageCubit();
    when(cubit.stream).thenAnswer((_) => const Stream.empty());
    when(cubit.state).thenReturn(const DetailsPageState(isVehicleSpecsExpanded: false));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<DetailsPageCubit>(
          create: (_) => cubit,
          child: VehicleSpecsWidget(car: testCar),
        ),
      ),
    );

    // Initially collapsed
    expect(find.text('Body'), findsNothing);

    // Tap collapsed button
    await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
    await tester.pumpAndSettle();

    // Now expanded
    expect(find.text('Body'), findsNothing);
    expect(find.text('Engine'), findsNothing);
    expect(find.text('Transmission'), findsNothing);
    expect(find.text('Mileage'), findsNothing);
    expect(find.text('Year'), findsNothing);
    expect(find.text('Color'), findsNothing);

    // Check that car data is not displayed
    expect(find.text('Sedan'), findsNothing); // capitalizeFirst
    expect(find.text('Electric'), findsNothing);
    expect(find.text('Automatic'), findsNothing);
    expect(find.text('12345'), findsNothing);
    expect(find.text('2022'), findsNothing);
    expect(find.text('red'), findsNothing); // capitalizeFirst
  });

  testWidgets('collapses and hides specifications when button is pressed again', (tester) async {
    final cubit = MockDetailsPageCubit();
    when(cubit.stream).thenAnswer((_) => const Stream.empty());
    when(cubit.state).thenReturn(const DetailsPageState(isVehicleSpecsExpanded: true));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<DetailsPageCubit>(
          create: (_) => cubit,
          child: VehicleSpecsWidget(car: testCar),
        ),
      ),
    );

    // Initially expanded
    expect(find.text('Body'), findsOneWidget);

    // Tap collapse button
    await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
    await tester.pumpAndSettle();

    // Now collapsed
    expect(find.text('Body'), findsOneWidget);
  });
}
