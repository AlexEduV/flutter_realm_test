import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:realm/realm.dart';
import 'package:test_futter_project/common/enums/body_type.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/fuel_type.dart';
import 'package:test_futter_project/common/enums/transmission_type.dart';
import 'package:test_futter_project/data/data_sources/realm_local_storage.dart';
import 'package:test_futter_project/data/dto/car_dto.dart';
import 'package:test_futter_project/data/models/scheme.dart';
import 'package:test_futter_project/data/repositories/car_repository_impl.dart';
import 'package:test_futter_project/domain/data_sources/car_api_service.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/models/owner_model.dart';

import 'car_repository_impl_test.mocks.dart';

@GenerateMocks([Realm, CarApiService, CarEntity, CarDto, RealmLocalStorage])
void main() {
  late MockRealm realm;
  late MockCarApiService apiService;
  late CarRepositoryImpl repository;
  late MockRealmLocalStorage localStorage;

  final mockCar = Car(ObjectId(), '1', 'Tesla', 'car');

  setUpAll(() {
    provideDummy<Car>(mockCar);
  });

  setUp(() {
    realm = MockRealm();
    apiService = MockCarApiService();
    localStorage = MockRealmLocalStorage();
    repository = CarRepositoryImpl(localStorage, apiService);
  });

  test('addCar calls realm.write and adds car', () {
    final carEntity = MockCarEntity();

    when(carEntity.carId).thenReturn('id');
    when(carEntity.model).thenReturn('Model Y');
    when(carEntity.manufacturer).thenReturn('Tesla');
    when(carEntity.year).thenReturn('2007');
    when(carEntity.owner).thenReturn(OwnerModel(id: 'test', name: 'Elon', linkedItemIds: []));
    when(carEntity.isVerified).thenReturn(true);
    when(carEntity.hotPromotionDescription).thenReturn(null);
    when(carEntity.kilometers).thenReturn(12345);
    when(carEntity.distanceTo).thenReturn(50);
    when(carEntity.price).thenReturn(60000);
    when(carEntity.type).thenReturn('car');

    when(realm.write(any)).thenAnswer((invocation) {
      final callback = invocation.positionalArguments.first as void Function();
      return callback();
    });
    when(realm.add(any as Car?, update: false)).thenReturn(mockCar);

    repository.addCar(carEntity);

    verify(localStorage.add(carEntity)).called(1);
  });

  test('deleteCarById deletes car if found and valid', () {
    final carId = '1';
    final car = mockCar;
    when(car.isValid).thenReturn(true);
    when(realm.find<Car>(carId)).thenReturn(car);
    when(realm.write(any)).thenAnswer((invocation) {
      invocation.positionalArguments.first();
    });

    repository.deleteCarById(carId);

    verify(localStorage.deleteById(any)).called(1);
  });

  test('deleteCarById does nothing if car not found', () {
    final carId = '1';
    when(realm.find<Car>(carId)).thenReturn(null);
    when(realm.write(any)).thenAnswer((invocation) {
      invocation.positionalArguments.first();
    });

    repository.deleteCarById(carId);

    verifyNever(realm.delete(any));
  });

  test('deleteAll calls realm.deleteAll<Car>()', () {
    when(realm.write(any)).thenAnswer((invocation) {
      invocation.positionalArguments.first();
    });

    repository.deleteAll();

    verify(localStorage.deleteAll()).called(1);
  });

  test('getCarById calls realm.getCarById()', () {
    when(realm.write(any)).thenAnswer((invocation) {
      invocation.positionalArguments.first();
    });
    when(localStorage.getCarById('id')).thenReturn(CarEntity.empty());

    repository.getCarById('id');

    verify(localStorage.getCarById('id')).called(1);
  });

  test('getMaxCarId calls realm.getMaxCarId()', () {
    when(realm.write(any)).thenAnswer((invocation) {
      invocation.positionalArguments.first();
    });
    when(localStorage.getMaxCarId()).thenReturn(1);

    repository.getMaxCarId();

    verify(localStorage.getMaxCarId()).called(1);
  });

  test('getAllCars returns mapped entities', () {
    final car = mockCar;

    when(localStorage.getAll()).thenReturn([CarEntity.empty()]);

    // Assuming CarEntity.fromSchema is a static method
    when(CarEntity.fromSchema(car)).thenReturn(MockCarEntity());

    final result = repository.getAllCars();

    expect(result.length, 1);
    expect(result.first, isA<CarEntity>());
  });

  test('syncCars deletes all, fetches, and adds cars', () async {
    final carDto = MockCarDto();

    when(carDto.id).thenReturn(ObjectId());
    when(carDto.carId).thenReturn('testId');
    when(carDto.manufacturer).thenReturn('Test Motors');
    when(carDto.model).thenReturn('Model X');
    when(carDto.year).thenReturn('2010');
    when(carDto.isVerified).thenReturn(false);
    when(carDto.hotPromotionDescription).thenReturn(null);
    when(carDto.kilometers).thenReturn(100);
    when(carDto.distanceTo).thenReturn(0);
    when(carDto.price).thenReturn(2000);
    when(carDto.type).thenReturn('car');
    when(carDto.bodyType).thenReturn('sedan');
    when(carDto.fuelType).thenReturn('gasoline');
    when(carDto.transmissionType).thenReturn('hybrid');
    when(
      carDto.owner,
    ).thenReturn(OwnerModel(id: 'test', name: 'James Morrison', linkedItemIds: []));

    final carDtos = [carDto];
    when(apiService.fetchCars()).thenAnswer((_) async => carDtos);
    when(apiService.carStream).thenAnswer(
      (_) => Stream.fromIterable([
        [
          CarDto(
            id: ObjectId(),
            carId: '1',
            model: 'Model S',
            manufacturer: 'Tesla',
            isVerified: false,
            type: CarType.car.name,
            bodyType: BodyType.sedan.name,
            fuelType: FuelType.hybrid.name,
            transmissionType: TransmissionType.manual.name,
          ),
        ],
      ]),
    );

    await repository.syncCars();

    verify(localStorage.deleteAll()).called(1);
    verify(localStorage.update(any)).called(1);
    verify(apiService.fetchCars()).called(1);
  });
}
