@Tags(['streams'])
library;

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/common/enums/body_type.dart';
import 'package:test_flutter_project/common/enums/car_type.dart';
import 'package:test_flutter_project/common/enums/fuel_type.dart';
import 'package:test_flutter_project/common/enums/transmission_type.dart';
import 'package:test_flutter_project/data/data_sources/local/realm_local_storage.dart';
import 'package:test_flutter_project/data/dto/car_dto.dart';
import 'package:test_flutter_project/data/models/scheme.dart';
import 'package:test_flutter_project/data/repositories/car_repository_impl.dart';
import 'package:test_flutter_project/domain/data_sources/remote/car_remote_data_source.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/entities/engine_entity.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';

import '../data_sources/remote/article_remote_data_source_impl_test.mocks.dart';
import 'car_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<CarRemoteDataSource>(),
  MockSpec<CarEntity>(),
  MockSpec<CarDto>(),
  MockSpec<RealmLocalStorage>(),
])
void main() {
  late MockCarRemoteDataSource apiService;
  late CarRepositoryImpl repository;
  late MockRealmLocalStorage localStorage;
  late MockLoggingService loggingService;

  final mockCar = Car(
    'car123',
    'Tesla',
    'car',
    model: 'Model S',
    isChecked: true,
    hotPromotionDescription: null,
    price: 80000,
    distanceTo: 50,
    year: '2020',
    owner: Person('John', 'Doe', 'test', linkedIds: []),
    mileage: 10000,
    bodyType: 'sedan',
    engine: Engine(fuelType: 'ev'),
    transmissionType: 'automatic',
    color: 'White',
    images: [],
  );

  group('car_repository_impl tests', () {
    setUpAll(() {
      provideDummy<Car>(mockCar);
    });

    setUp(() {
      apiService = MockCarRemoteDataSource();
      localStorage = MockRealmLocalStorage();
      loggingService = MockLoggingService();
      repository = CarRepositoryImpl(localStorage, apiService, loggingService);
    });

    test('addCar calls realm.write and adds car', () {
      final carEntity = MockCarEntity();

      when(carEntity.carId).thenReturn('id');
      when(carEntity.model).thenReturn('Model Y');
      when(carEntity.manufacturer).thenReturn('Tesla');
      when(carEntity.year).thenReturn('2007');
      when(
        carEntity.owner,
      ).thenReturn(OwnerEntity(id: 'test', firstName: 'Elon', lastName: 'Musk', linkedItemIds: []));
      when(carEntity.isVerified).thenReturn(true);
      when(carEntity.promoType).thenReturn(null);
      when(carEntity.mileage).thenReturn(12345);
      when(carEntity.distanceTo).thenReturn(50);
      when(carEntity.price).thenReturn(60000);
      when(carEntity.type).thenReturn('car');

      repository.addCar(carEntity);

      verify(localStorage.addCar(carEntity)).called(1);
    });

    test('deleteCarById deletes car if found and valid', () {
      final carId = '1';
      final car = mockCar;
      car.isChecked = true;

      repository.deleteCarById(carId);

      verify(localStorage.deleteCarById(any)).called(1);
    });

    test('deleteCarById delegates to localStorage.deleteById', () {
      final carId = '1';

      repository.deleteCarById(carId);

      verify(localStorage.deleteCarById(carId)).called(1);
    });

    test('deleteAll calls realm.deleteAll<Car>()', () {
      repository.deleteAll();

      verify(localStorage.deleteAllCars()).called(1);
    });

    test('getCarById calls realm.getCarById()', () {
      when(localStorage.getCarById('id')).thenReturn(CarEntity.empty());

      repository.getCarById('id');

      verify(localStorage.getCarById('id')).called(1);
    });

    test('getMaxCarId calls realm.getMaxCarId()', () {
      when(localStorage.getMaxCarId()).thenReturn(1);

      repository.getMaxCarId();

      verify(localStorage.getMaxCarId()).called(1);
    });

    test('getAllCars returns mapped entities', () {
      when(localStorage.getAllCars()).thenReturn([CarEntity.empty()]);

      final result = repository.getAllCars();

      expect(result.length, 1);
      expect(result.first, isA<CarEntity>());
    });

    test('syncCars deletes all, fetches, and adds cars', () async {
      final carDto = CarDto(
        carId: 'testId',
        manufacturer: 'Test Motors',
        model: 'Model X',
        year: '2010',
        isVerified: false,
        mileage: 100,
        distanceTo: 0,
        price: 2000,
        type: 'car',
        bodyType: 'sedan',
        engine: const EngineEntity(type: 'gasoline'),
        transmissionType: 'hybrid',
        color: 'White',
        images: [],
        owner: OwnerEntity(id: 'test', firstName: 'James', lastName: 'Morrison', linkedItemIds: []),
      );

      final carDtos = [carDto];
      when(apiService.fetchCars()).thenAnswer((_) async => carDtos);
      when(apiService.carStream).thenAnswer(
        (_) => Stream.fromIterable([
          [
            CarDto(
              carId: '1',
              model: 'Model S',
              manufacturer: 'Tesla',
              isVerified: false,
              type: CarType.car.name,
              bodyType: BodyType.sedan.name,
              engine: EngineEntity(type: FuelType.hybrid.name),
              transmissionType: TransmissionType.manual.name,
            ),
          ],
        ]),
      );

      await repository.syncCars();

      verify(localStorage.deleteAllCars()).called(1);
      verify(localStorage.updateCar(any)).called(1);
      verify(apiService.fetchCars()).called(1);
    });
  });
}
