import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/common/enums/body_type.dart';
import 'package:test_flutter_project/common/enums/fuel_type.dart';
import 'package:test_flutter_project/common/enums/transmission_type.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/usecases/database/add_car_use_case.dart';

import '../../repositories/car_repository_test.mocks.dart';

void main() {
  group('AddCarUseCase', () {
    late MockCarRepository mockCarRepository;
    late AddCarUseCase useCase;

    setUp(() {
      mockCarRepository = MockCarRepository();
      useCase = AddCarUseCase(mockCarRepository);
    });

    test('calls addCar on repository with correct params', () {
      final car = CarEntity(
        carId: '1',
        model: 'Model S',
        manufacturer: 'Tesla',
        type: 'car',
        isVerified: true,
        year: '2022',
        kilometers: 1000,
        distanceTo: 5,
        price: 90000,
        fuelType: FuelType.ev.name,
        bodyType: BodyType.sedan.name,
        transmissionType: TransmissionType.automatic.name,
      );

      useCase.call(car);

      verify(mockCarRepository.addCar(car)).called(1);
    });
  });
}
