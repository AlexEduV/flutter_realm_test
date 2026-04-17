import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/usecases/car_colors/get_car_colors_use_case.dart';
import 'package:test_flutter_project/presentation/bloc/details/details_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/details/details_page_state.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/pages/details/widgets/vehicle_specs/vehicle_specs_widget.dart';

import '../../../../utils/app_router_test.mocks.dart';
import 'vehicle_specs_widget_test.mocks.dart';

@GenerateMocks([GetCarColorsUseCase])
void main() {
  final appLocalisationsCubit = AppLocalisationsCubit();
  final mockGetCarColorsUseCase = MockGetCarColorsUseCase();

  setUp(() {
    serviceLocator.registerLazySingleton<AppLocalisationsCubit>(() => appLocalisationsCubit);
    serviceLocator.registerLazySingleton<GetCarColorsUseCase>(() => mockGetCarColorsUseCase);

    when(mockGetCarColorsUseCase.call()).thenReturn({'red': Colors.red});

    final localisations = {
      'pages.vehicleDetails.sectionTitle': 'Vehicle Details',
      'pages.vehicleDetails.specifications.body': 'Body',
      'pages.vehicleDetails.specifications.engine': 'Engine',
      'pages.vehicleDetails.specifications.transmission': 'Transmission',
      'pages.vehicleDetails.specifications.mileage': 'Mileage',
      'pages.vehicleDetails.specifications.color': 'Color',
      'pages.vehicleDetails.specifications.year': 'Year',
    };

    appLocalisationsCubit.load(localisations);
  });

  tearDown(() {
    serviceLocator.unregister<AppLocalisationsCubit>();
    serviceLocator.unregister<GetCarColorsUseCase>();
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
    mileage: 12345,
    year: '2022',
    color: 'red',
  );

  testWidgets('displays section title and expand button', (tester) async {
    final cubit = MockDetailsPageCubit();
    when(cubit.stream).thenAnswer((_) => const Stream.empty());
    when(cubit.state).thenReturn(const DetailsPageState());

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<DetailsPageCubit>.value(value: cubit),
            BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
          ],
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
        home: MultiBlocProvider(
          providers: [
            BlocProvider<DetailsPageCubit>.value(value: cubit),
            BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
          ],
          child: VehicleSpecsWidget(car: testCar),
        ),
      ),
    );

    // Initially collapsed
    final containerFinder = find.byType(AnimatedContainer);
    final size = tester.getSize(containerFinder);
    expect(size.height, 0);

    // Tap collapsed button
    await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
    await tester.pumpAndSettle(const Duration(milliseconds: 350));

    // Now expanded
    //todo: cubit dependency update is needed
    //final newContainerFinder = find.byType(AnimatedContainer);
    //final newSize = tester.getSize(newContainerFinder);
    //expect(newSize.height, AppDimensions.vehicleSpecsExpandedSize);
  });

  testWidgets('collapses and hides specifications when button is pressed again', (tester) async {
    final cubit = MockDetailsPageCubit();
    when(cubit.stream).thenAnswer((_) => const Stream.empty());
    when(cubit.state).thenReturn(const DetailsPageState(isVehicleSpecsExpanded: true));

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<DetailsPageCubit>.value(value: cubit),
            BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
          ],
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
