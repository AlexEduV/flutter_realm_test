import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:realm/realm.dart';
import 'package:test_futter_project/data/data_sources/realm_local_storage.dart';
import 'package:test_futter_project/data/models/scheme.dart';

import 'realm_local_storage_test.mocks.dart';

@GenerateMocks([Realm])
void main() {
  late MockRealm mockRealm;
  late RealmLocalStorage storage;

  final mockCar = Car(ObjectId(), '1', 'Tesla', 'car');

  setUpAll(() {
    provideDummy<Car>(mockCar);
  });

  setUp(() {
    mockRealm = MockRealm();
    storage = RealmLocalStorage(mockRealm);
  });

  //todo: tests are not working
  // test('add should call realm.write and realm.add with Car', () {
  //   final carEntity = CarEntity(
  //     carId: 'car123',
  //     model: 'Model S',
  //     manufacturer: 'Tesla',
  //     type: CarType.car.name,
  //     isVerified: true,
  //     isHotPromotion: false,
  //     year: '2022',
  //     kilometers: 1000,
  //     distanceTo: 5,
  //     price: 90000,
  //   );
  //
  //   // You may need to mock CarExtensions.fromEntity
  //   when(mockRealm.write(any)).thenAnswer((invocation) {
  //     final fn = invocation.positionalArguments[0] as Function;
  //     fn();
  //   });
  //
  //   storage.add(carEntity);
  //
  //   verify(mockRealm.write(any)).called(1);
  //   // You can add more verifications if you mock CarExtensions.fromEntity
  // });
  //
  // test('update should call realm.write and realm.add with update=true', () {
  //   final car = Car(ObjectId(), 'car123', 'Tesla', CarType.car.name);
  //
  //   when(mockRealm.write(any)).thenAnswer((invocation) {
  //     final fn = invocation.positionalArguments[0] as Function;
  //     fn();
  //   });
  //
  //   storage.update(car);
  //
  //   verify(mockRealm.write(any)).called(1);
  //   // You can add more verifications if you mock realm.add
  // });

  // test('deleteById should call realm.write and realm.delete if car is found and valid', () {
  //   final car = Car(ObjectId(), 'car123', 'Tesla', CarType.car.name);
  //
  //   when(mockRealm.write(any)).thenAnswer((invocation) {
  //     final fn = invocation.positionalArguments[0] as Function;
  //     fn();
  //   });
  //
  //   when(mockRealm.all<Car>().query('carId == \$0', ['car123'])).thenReturn(MockRealmResults());
  //
  //   storage.deleteById(car.carId);
  //
  //   verify(mockRealm.write(any)).called(1);
  //   verify(mockRealm.delete(car)).called(1);
  // });

  test('deleteAll should call realm.write and realm.deleteAll<Car>', () {
    when(mockRealm.write(any)).thenAnswer((invocation) {
      final fn = invocation.positionalArguments[0] as Function;
      fn();
    });

    storage.deleteAllCars();

    verify(mockRealm.write(any)).called(1);
    verify(mockRealm.deleteAll<Car>()).called(1);
  });

  // You can add more tests for getAll, watch, and initUser as needed.
}
