import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:realm/realm.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/repositories/car_repository.dart';

import 'car_repository_test.mocks.dart';

@GenerateMocks([CarRepository])
void main() {
  late MockCarRepository mockRepo;

  setUp(() {
    mockRepo = MockCarRepository();
  });

  test('getAllCars returns a list of CarEntity', () {
    final cars = [
      CarEntity(
        carId: '1',
        model: 'Model S',
        manufacturer: 'Tesla',
        isVerified: true,
        isHotPromotion: false,
      ),
    ];

    when(mockRepo.getAllCars()).thenReturn(cars);

    final result = mockRepo.getAllCars();

    expect(result, cars);
    verify(mockRepo.getAllCars()).called(1);
  });

  test('addCar calls addCar with correct argument', () {
    final car = CarEntity(
      carId: '2',
      model: 'Civic',
      manufacturer: 'Honda',
      isVerified: false,
      isHotPromotion: true,
    );

    mockRepo.addCar(car);

    verify(mockRepo.addCar(car)).called(1);
  });

  test('syncCars completes', () async {
    when(mockRepo.syncCars()).thenAnswer((_) async {});

    await mockRepo.syncCars();

    verify(mockRepo.syncCars()).called(1);
  });

  test('watchCars emits a list of CarEntity', () async {
    final cars = [
      CarEntity(
        carId: '3',
        model: 'Corolla',
        manufacturer: 'Toyota',
        isVerified: true,
        isHotPromotion: false,
      ),
    ];

    when(mockRepo.watchCars()).thenAnswer((_) => Stream.value(cars));

    final stream = mockRepo.watchCars();

    expect(await stream?.first, cars);
    verify(mockRepo.watchCars()).called(1);
  });

  test('deleteAll calls deleteAll', () {
    mockRepo.deleteAll();

    verify(mockRepo.deleteAll()).called(1);
  });

  test('deleteCarById calls deleteCarById with correct id', () {
    final id = ObjectId();

    mockRepo.deleteCarById(id);

    verify(mockRepo.deleteCarById(id)).called(1);
  });
}
