import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/common/enums/body_type.dart';
import 'package:test_flutter_project/common/enums/car_type.dart';
import 'package:test_flutter_project/common/enums/fuel_type.dart';
import 'package:test_flutter_project/common/enums/transmission_type.dart';
import 'package:test_flutter_project/data/data_sources/local/realm_local_storage.dart';
import 'package:test_flutter_project/data/models/scheme.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/entities/engine_entity.dart';

import '../../../common/fakes/fake_realm.dart';

void main() {
  late FakeRealm fakeRealm;
  late RealmLocalStorage storage;

  final testCarEntity = CarEntity(
    carId: 'car1',
    model: 'Model S',
    manufacturer: 'Tesla',
    type: CarType.car.name,
    isVerified: true,
    year: '2022',
    mileage: 1000,
    distanceTo: 5,
    price: 90000,
    engine: EngineEntity(type: FuelType.ev.name),
    bodyType: BodyType.sedan.name,
    transmissionType: TransmissionType.automatic.name,
  );

  setUp(() {
    fakeRealm = FakeRealm();
    storage = RealmLocalStorage(fakeRealm);
  });

  group('RealmLocalStorage', () {
    test('add inserts a car into Realm', () {
      storage.addCar(testCarEntity);

      expect(fakeRealm.all<Car>().length, 1);
      expect(fakeRealm.all<Car>().first.manufacturer, 'Tesla');
    });

    test('update overwrites an existing car by primary key', () {
      fakeRealm.write(() => fakeRealm.add(Car('1', 'Tesla', CarType.car.name)));

      storage.updateCar(CarEntity.fromSchema(Car('1', 'BMW', CarType.car.name)));

      expect(fakeRealm.all<Car>().length, 1);
      expect(fakeRealm.all<Car>().first.manufacturer, 'BMW');
    });

    test('deleteById removes the matching car', () {
      fakeRealm.write(() => fakeRealm.add(Car('123', 'Tesla', CarType.car.name)));

      storage.deleteCarById('123');

      expect(fakeRealm.all<Car>().length, 0);
    });

    test('deleteAllCars removes all cars', () {
      fakeRealm.write(() {
        fakeRealm.add(Car('1', 'Tesla', CarType.car.name));
        fakeRealm.add(Car('2', 'BMW', CarType.car.name));
      });

      storage.deleteAllCars();

      expect(fakeRealm.all<Car>().length, 0);
    });

    test('getMaxCarId returns 0 when database is empty', () {
      expect(storage.getMaxCarId(), 0);
    });

    test('getMaxCarId returns the highest numeric carId', () {
      fakeRealm.write(() {
        fakeRealm.add(Car('3', 'Tesla', CarType.car.name));
        fakeRealm.add(Car('1', 'BMW', CarType.car.name));
        fakeRealm.add(Car('7', 'Audi', CarType.car.name));
      });

      expect(storage.getMaxCarId(), 7);
    });
  });
}
