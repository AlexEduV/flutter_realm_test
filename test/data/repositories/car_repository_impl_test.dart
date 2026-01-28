import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:realm/realm.dart';
import 'package:test_futter_project/data/data_sources/realm_local_storage.dart';
import 'package:test_futter_project/data/dto/car_dto.dart';
import 'package:test_futter_project/data/models/scheme.dart';
import 'package:test_futter_project/data/repositories/car_repository_impl.dart';
import 'package:test_futter_project/domain/data_sources/car_api_service.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';

import 'car_repository_impl_test.mocks.dart';

@GenerateMocks([Realm, CarApiService, Car, CarEntity, CarDto, RealmLocalStorage])
void main() {
  late MockRealm realm;
  late MockCarApiService apiService;
  late CarRepositoryImpl repository;
  late MockRealmLocalStorage localStorage;

  final mockCar = Car(ObjectId(), '1', 'Tesla');

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
    when(carEntity.owner).thenReturn('Elon');
    when(carEntity.isVerified).thenReturn(true);
    when(carEntity.isHotPromotion).thenReturn(false);
    when(carEntity.kilometers).thenReturn(12345);
    when(carEntity.distanceTo).thenReturn(50);
    when(carEntity.price).thenReturn(60000);

    when(realm.write(any)).thenAnswer((invocation) {
      final callback = invocation.positionalArguments.first as void Function();
      return callback();
    });
    when(realm.add(any as Car?, update: false)).thenReturn(mockCar);

    repository.addCar(carEntity);

    verify(localStorage.add(carEntity)).called(1);
  });

  test('deleteCarById deletes car if found and valid', () {
    final carId = ObjectId();
    final car = MockCar();
    when(car.isValid).thenReturn(true);
    when(realm.find<Car>(carId)).thenReturn(car);
    when(realm.write(any)).thenAnswer((invocation) {
      invocation.positionalArguments.first();
    });

    repository.deleteCarById(carId);

    verify(localStorage.deleteById(any)).called(1);
  });

  test('deleteCarById does nothing if car not found', () {
    final carId = ObjectId();
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

  test('getAllCars returns mapped entities', () {
    final car = MockCar();

    when(localStorage.getAll()).thenReturn([CarEntity.empty()]);

    // Assuming CarEntity.fromSchema is a static method
    when(CarEntity.fromSchema(car)).thenReturn(MockCarEntity());

    final result = repository.getAllCars();

    expect(result.length, 1);
    expect(result.first, isA<CarEntity>());
  });

  // test('syncCars deletes all, fetches, and adds cars', () async {
  //   final carDto = MockCarDto();
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
