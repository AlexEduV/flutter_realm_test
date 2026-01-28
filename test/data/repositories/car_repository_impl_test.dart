import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:realm/realm.dart';
import 'package:test_futter_project/data/data_sources/car_api_service.dart';
import 'package:test_futter_project/data/models/scheme.dart';
import 'package:test_futter_project/data/repositories/car_repository_impl.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';

import 'car_repository_impl_test.mocks.dart';

@GenerateMocks([Realm, CarApiService, Car, CarEntity])
void main() {
  late MockRealm realm;
  late MockCarApiService apiService;
  late CarRepositoryImpl repository;

  setUp(() {
    realm = MockRealm();
    apiService = MockCarApiService();
    repository = CarRepositoryImpl(realm, apiService);
  });

  test('addCar calls realm.write and adds car', () {
    final carEntity = MockCarEntity();
    when(realm.write(any)).thenAnswer((invocation) {
      return invocation.positionalArguments.first;
    });

    repository.addCar(carEntity);

    verify(realm.write(any)).called(1);
  });

  // test('deleteCarById deletes car if found and valid', () {
  //   final carId = ObjectId();
  //   final car = MockCar();
  //   when(car.isValid).thenReturn(true);
  //   when(realm.find<Car>(carId)).thenReturn(car);
  //   when(realm.write(any)).thenAnswer((invocation) {
  //     invocation.positionalArguments.first();
  //   });
  //
  //   repository.deleteCarById(carId);
  //
  //   verify(realm.delete(car)).called(1);
  // });
  //
  // test('deleteCarById does nothing if car not found', () {
  //   final carId = ObjectId();
  //   when(realm.find<Car>(carId)).thenReturn(null);
  //   when(realm.write(any)).thenAnswer((invocation) {
  //     invocation.positionalArguments.first();
  //   });
  //
  //   repository.deleteCarById(carId);
  //
  //   verifyNever(realm.delete(any));
  // });
  //
  // test('deleteAll calls realm.deleteAll<Car>()', () {
  //   when(realm.write(any)).thenAnswer((invocation) {
  //     invocation.positionalArguments.first();
  //   });
  //
  //   repository.deleteAll();
  //
  //   verify(realm.deleteAll<Car>()).called(1);
  // });
  //
  // test('getAllCars returns mapped entities', () {
  //   final car = MockCar();
  //   final cars = [car];
  //   when(realm.all<Car>()).thenReturn(cars);
  //
  //   // Assuming CarEntity.fromSchema is a static method
  //   when(CarEntity.fromSchema(car)).thenReturn(MockCarEntity());
  //
  //   final result = repository.getAllCars();
  //
  //   expect(result.length, 1);
  //   expect(result.first, isA<CarEntity>());
  // });
  //
  // test('syncCars deletes all, fetches, and adds cars', () async {
  //   final carDto = MockCarEntity();
  //   final carDtos = [carDto];
  //   when(apiService.fetchCars()).thenAnswer((_) async => carDtos);
  //   when(realm.write(any)).thenAnswer((invocation) {
  //     invocation.positionalArguments.first();
  //   });
  //   when(apiService.carStream).thenAnswer((_) => const Stream.empty());
  //
  //   await repository.syncCars();
  //
  //   verify(realm.write(any)).called(greaterThanOrEqualTo(1));
  //   verify(apiService.fetchCars()).called(1);
  // });
  //
  // test('watchCars maps realm changes to entities', () async {
  //   // Setup a fake stream of RealmResultsChanges
  //   final car = MockCar();
  //   final changes = RealmResultsChanges<Car>([car], [], [], [], []);
  //   final controller = StreamController<RealmResultsChanges<Car>>();
  //   when(realm.all<Car>()).thenReturn([car]);
  //   when(realm.all<Car>().changes).thenAnswer((_) => controller.stream);
  //
  //   // Assuming CarExtensions.toEntity returns a CarEntity
  //   when(car.toEntity(car)).thenReturn(MockCarEntity());
  //
  //   final stream = repository.watchCars();
  //   controller.add(changes);
  //
  //   final result = await stream.first;
  //   expect(result, isA<List<CarEntity>>());
  //   controller.close();
  // });
}
