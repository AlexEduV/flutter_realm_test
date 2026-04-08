import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/common/enums/body_type.dart';
import 'package:test_futter_project/common/enums/fuel_type.dart';
import 'package:test_futter_project/common/enums/promo_type.dart';
import 'package:test_futter_project/common/enums/transmission_type.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/usecases/articles/fetch_articles_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/sync_cars_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/watch_cars_use_case.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_state.dart';

import 'explore_page_cubit_test.mocks.dart';

@GenerateMocks([SyncCarsUseCase, WatchCarsUseCase, FetchArticlesUseCase])
void main() {
  late MockSyncCarsUseCase mockSyncCarsUseCase;
  late MockWatchCarsUseCase mockWatchCarsUseCase;
  late MockFetchArticlesUseCase mockFetchArticlesUseCase;

  late ExplorePageCubit cubit;

  final carList = [
    CarEntity(
      carId: '1',
      model: 'Model S',
      manufacturer: 'Tesla',
      isVerified: true,
      type: 'car',
      fuelType: FuelType.ev.name,
      bodyType: BodyType.sedan.name,
      transmissionType: TransmissionType.automatic.name,
    ),
    CarEntity(
      carId: '2',
      model: 'Civic',
      manufacturer: 'Honda',
      isVerified: false,
      promoType: PromoType.limitedTimeOffer,
      type: 'car',
      fuelType: FuelType.hybrid.name,
      bodyType: BodyType.sedan.name,
      transmissionType: TransmissionType.automatic.name,
    ),
  ];

  setUp(() {
    mockWatchCarsUseCase = MockWatchCarsUseCase();
    mockSyncCarsUseCase = MockSyncCarsUseCase();
    mockFetchArticlesUseCase = MockFetchArticlesUseCase();
    cubit = ExplorePageCubit(mockWatchCarsUseCase, mockSyncCarsUseCase, mockFetchArticlesUseCase);
  });

  tearDown(() async {
    await cubit.close();
  });

  blocTest<ExplorePageCubit, ExplorePageState>(
    'should init',
    setUp: () {
      when(mockSyncCarsUseCase.call()).thenAnswer((_) async => {});
      when(mockWatchCarsUseCase.call()).thenAnswer((_) => Stream.value(carList));
      when(mockFetchArticlesUseCase.call()).thenAnswer((_) async => []);
    },
    build: () {
      return cubit;
    },
    act: (cubit) => cubit.init(),
    expect: () => [
      isA<ExplorePageState>().having((s) => s.isLoading, 'isLoading', true),
      isA<ExplorePageState>().having((s) => s.isLoading, 'isLoading', true),
      isA<ExplorePageState>().having((s) => s.isLoading, 'isLoading', false),
      isA<ExplorePageState>().having((s) => s.cars, 'cars', carList),
    ],
    verify: (_) {
      verify(mockWatchCarsUseCase.call()).called(1);
      verify(mockSyncCarsUseCase.call()).called(1);
    },
  );

  blocTest<ExplorePageCubit, ExplorePageState>(
    'updateCars emits state with new cars',
    build: () => cubit,
    act: (cubit) => cubit.updateCars(carList),
    expect: () => [isA<ExplorePageState>().having((s) => s.cars, 'cars', carList)],
  );

  blocTest<ExplorePageCubit, ExplorePageState>(
    'removeCarAt removes the car at the given index',
    build: () => cubit,
    seed: () => ExplorePageState(cars: carList),
    act: (cubit) => cubit.removeCarById(0),
    expect: () => [
      isA<ExplorePageState>()
          .having((s) => s.cars.length, 'cars.length', 1)
          .having((s) => s.cars.first.carId, 'remaining carId', '2'),
    ],
  );
}
