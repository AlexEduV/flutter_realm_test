import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/common/enums/body_type.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/fuel_type.dart';
import 'package:test_futter_project/common/enums/transmission_type.dart';
import 'package:test_futter_project/domain/data_sources/base_local_storage.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';

import 'base_local_storage_test.mocks.dart';

@GenerateMocks([BaseLocalStorage])
void main() {
  late MockBaseLocalStorage mockStorage;

  setUp(() {
    mockStorage = MockBaseLocalStorage();
  });

  group('BaseLocalStorage', () {
    test('getAll returns a list of CarEntity', () {
      final cars = [
        CarEntity(
          carId: 'car1',
          model: 'Model S',
          manufacturer: 'Tesla',
          type: CarType.car.name,
          isVerified: true,
          year: '2022',
          kilometers: 1000,
          distanceTo: 5,
          price: 90000,
          fuelType: FuelType.ev.name,
          bodyType: BodyType.sedan.name,
          transmissionType: TransmissionType.automatic.name,
        ),
      ];

      when(mockStorage.getAll()).thenReturn(cars);

      final result = mockStorage.getAll();

      expect(result, isA<List<CarEntity>>());
      expect(result.length, 1);
      expect(result.first.manufacturer, 'Tesla');
    });

    test('add can be called with any object', () {
      final car = CarEntity(
        carId: 'car2',
        model: 'Civic',
        manufacturer: 'Honda',
        type: CarType.car.name,
        isVerified: false,
        year: '2020',
        kilometers: 5000,
        distanceTo: 10,
        price: 20000,
        fuelType: FuelType.diesel.name,
        bodyType: BodyType.sedan.name,
        transmissionType: TransmissionType.manual.name,
      );

      mockStorage.add(car);

      verify(mockStorage.add(car)).called(1);
    });

    test('update can be called with any object', () {
      final car = CarEntity(
        carId: 'car3',
        model: 'Corolla',
        manufacturer: 'Toyota',
        type: CarType.car.name,
        isVerified: true,
        year: '2019',
        kilometers: 8000,
        distanceTo: 15,
        price: 15000,
        fuelType: FuelType.gasoline.name,
        bodyType: BodyType.sedan.name,
        transmissionType: TransmissionType.automatic.name,
      );

      mockStorage.update(car);

      verify(mockStorage.update(car)).called(1);
    });

    test('watch returns a Stream', () {
      final carStream = Stream<List<CarEntity>>.value([
        CarEntity(
          carId: 'car4',
          model: 'Mustang',
          manufacturer: 'Ford',
          type: CarType.car.name,
          isVerified: true,
          hotPromotionDescription: 'Hot Promo',
          year: '2021',
          kilometers: 3000,
          distanceTo: 2,
          price: 50000,
          fuelType: FuelType.hybrid.name,
          bodyType: BodyType.coupe.name,
          transmissionType: TransmissionType.manual.name,
        ),
      ]);

      when(mockStorage.watch<CarEntity>()).thenAnswer((_) => carStream);

      expect(mockStorage.watch<CarEntity>(), emits(isA<List<CarEntity>>()));
    });

    test('deleteAll can be called', () {
      mockStorage.deleteAll();

      verify(mockStorage.deleteAll()).called(1);
    });

    test('deleteById can be called with car Id', () {
      final id = '1';

      mockStorage.deleteById(id);

      verify(mockStorage.deleteById(id)).called(1);
    });

    test('initUser returns a UserEntity', () {
      final user = const UserEntity(
        userId: 'u1',
        firstName: 'John',
        lastName: 'Doe',
        isLocationPermissionGranted: true,
        favoriteIds: [],
        email: 'mock@gmail.com',
      );

      when(mockStorage.initUser()).thenReturn(user);

      final result = mockStorage.initUser();

      expect(result, isA<UserEntity>());
      expect(result.userId, 'u1');
    });
  });
}
