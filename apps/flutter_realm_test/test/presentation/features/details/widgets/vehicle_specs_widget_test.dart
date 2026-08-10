import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:realm/realm.dart';
import 'package:test_flutter_project/common/enums/fuel_type.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/entities/engine_entity.dart';
import 'package:test_flutter_project/domain/usecases/car_colors/get_car_colors_use_case.dart';
import 'package:test_flutter_project/presentation/features/details/details_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/details/details_page_state.dart';
import 'package:test_flutter_project/presentation/features/details/widgets/vehicle_specs/vehicle_specs_widget.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';

import '../../../../utils/app_router_test.mocks.dart';
import '../../explore/explore_page_cubit_test.mocks.dart';
import 'owner_widget_test.mocks.dart';
import 'vehicle_specs_widget_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GetCarColorsUseCase>()])
void main() {
  final appLocalisationsCubit = AppLocalisationsCubit();
  final mockGetCarColorsUseCase = MockGetCarColorsUseCase();
  final mockGetConversationByOwnerIdUseCase = MockGetConversationByOwnerIdUseCase();

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
    id: ObjectId(),
    carId: '1',
    model: 'Model S',
    manufacturer: 'Tesla',
    isVerified: true,
    type: 'Car',
    bodyType: 'sedan',
    engine: EngineEntity(type: FuelType.ev.name),
    transmissionType: 'automatic',
    mileage: 12345,
    year: '2022',
    color: 'red',
  );

  testWidgets('displays section title and expand button', (tester) async {
    final cubit = MockDetailsPageCubit();
    when(cubit.stream).thenAnswer((_) => const Stream.empty());
    when(cubit.state).thenReturn(const DetailsPageState());

    when(cubit.state).thenReturn(DetailsPageState(car: testCar));

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<DetailsPageCubit>.value(value: cubit),
            BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
          ],
          child: const VehicleSpecsWidget(),
        ),
      ),
    );

    expect(find.text('Vehicle Details'), findsOneWidget);
    expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
  });

  testWidgets('expands and shows specifications when button is pressed', (tester) async {
    final mockGetCarByIdUseCase = MockGetCarByIdUseCase();
    when(mockGetCarByIdUseCase.call(any)).thenReturn(testCar);
    final cubit = DetailsPageCubit(
      mockGetCarByIdUseCase,
      mockGetCarColorsUseCase,
      mockGetConversationByOwnerIdUseCase,
    );
    cubit.loadData(testCar.carId);
    cubit.setVehicleSpecsExpansionState(false);

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<DetailsPageCubit>.value(value: cubit),
            BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
          ],
          child: const VehicleSpecsWidget(),
        ),
      ),
    );

    // Initially collapsed
    expect(tester.getSize(find.byType(AnimatedContainer)).height, 0);

    // Tap expand button
    await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
    await tester.pumpAndSettle(const Duration(milliseconds: 350));

    // Now expanded
    expect(
      tester.getSize(find.byType(AnimatedContainer)).height,
      AppDimensions.vehicleSpecsExpandedSize,
    );
  });

  testWidgets('collapses and hides specifications when button is pressed again', (tester) async {
    final mockGetCarByIdUseCase = MockGetCarByIdUseCase();
    when(mockGetCarByIdUseCase.call(any)).thenReturn(testCar);
    final cubit = DetailsPageCubit(
      mockGetCarByIdUseCase,
      mockGetCarColorsUseCase,
      mockGetConversationByOwnerIdUseCase,
    );
    cubit.loadData(testCar.carId);

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<DetailsPageCubit>.value(value: cubit),
            BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
          ],
          child: const VehicleSpecsWidget(),
        ),
      ),
    );

    // Initially expanded (default state)
    expect(
      tester.getSize(find.byType(AnimatedContainer)).height,
      AppDimensions.vehicleSpecsExpandedSize,
    );

    // Tap collapse button
    await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
    await tester.pumpAndSettle(const Duration(milliseconds: 350));

    // Now collapsed
    expect(tester.getSize(find.byType(AnimatedContainer)).height, 0);
  });
}
