import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/repositories/car_repository.dart';
import 'package:test_futter_project/presentation/bloc/home/home_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/home_page_state.dart';

import 'home_page_cubit_test.mocks.dart';

@GenerateMocks([CarRepository])
void main() {
  late MockCarRepository mockRepo;
  late HomePageCubit cubit;

  final carList = [
    CarEntity(
      carId: '1',
      model: 'Model S',
      manufacturer: 'Tesla',
      isVerified: true,
      isHotPromotion: false,
    ),
    CarEntity(
      carId: '2',
      model: 'Civic',
      manufacturer: 'Honda',
      isVerified: false,
      isHotPromotion: true,
    ),
  ];

  setUp(() {
    mockRepo = MockCarRepository();
    cubit = HomePageCubit(mockRepo);
  });

  tearDown(() async {
    await cubit.close();
  });

  //todo: mocking does not work here. Probably need to generate with Mockito;
  blocTest<HomePageCubit, HomePageState>(
    'should init',
    setUp: () {
      when(mockRepo.syncCars()).thenAnswer((_) async => {});
      when(mockRepo.watchCars()).thenAnswer((_) => Stream.value(carList));
    },
    build: () {
      return cubit;
    },
    act: (cubit) => cubit.init(),
    expect: () => [
      isA<HomePageState>().having((s) => s.isLoading, 'isLoading', true),
      isA<HomePageState>().having((s) => s.isLoading, 'isLoading', false),
      isA<HomePageState>().having((s) => s.cars, 'cars', carList),
    ],
    verify: (_) {
      verify(mockRepo.syncCars()).called(1);
      verify(mockRepo.watchCars()).called(1);
    },
  );

  blocTest<HomePageCubit, HomePageState>(
    'updateCars emits state with new cars',
    build: () => cubit,
    act: (cubit) => cubit.updateCars(carList),
    expect: () => [isA<HomePageState>().having((s) => s.cars, 'cars', carList)],
  );

  blocTest<HomePageCubit, HomePageState>(
    'removeCarAt removes the car at the given index',
    build: () => cubit,
    seed: () => HomePageState(cars: carList),
    act: (cubit) => cubit.removeCarAt(0),
    expect: () => [
      isA<HomePageState>()
          .having((s) => s.cars.length, 'cars.length', 1)
          .having((s) => s.cars.first.carId, 'remaining carId', '2'),
    ],
  );
}
