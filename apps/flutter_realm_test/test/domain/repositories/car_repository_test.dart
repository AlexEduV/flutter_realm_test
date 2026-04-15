import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/common/enums/body_type.dart';
import 'package:test_flutter_project/common/enums/fuel_type.dart';
import 'package:test_flutter_project/common/enums/promo_type.dart';
import 'package:test_flutter_project/common/enums/transmission_type.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/repositories/car_repository.dart';

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
        type: 'car',
        isVerified: true,
        fuelType: FuelType.ev.name,
        bodyType: BodyType.sedan.name,
        transmissionType: TransmissionType.automatic.name,
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
      promoType: PromoType.oneOwner,
      type: 'car',
      fuelType: FuelType.hybrid.name,
      bodyType: BodyType.sedan.name,
      transmissionType: TransmissionType.automatic.name,
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
        type: 'car',
        fuelType: FuelType.gasoline.name,
        bodyType: BodyType.sedan.name,
        transmissionType: TransmissionType.manual.name,
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
    final id = '1';

    mockRepo.deleteCarById(id);

    verify(mockRepo.deleteCarById(id)).called(1);
  });
}
