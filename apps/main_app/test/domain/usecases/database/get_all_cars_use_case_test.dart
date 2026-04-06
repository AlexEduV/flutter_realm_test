import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/common/enums/body_type.dart';
import 'package:test_futter_project/common/enums/fuel_type.dart';
import 'package:test_futter_project/common/enums/transmission_type.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/usecases/database/get_all_cars_use_case.dart';

import '../../repositories/car_repository_test.mocks.dart';

void main() {
  group('GetAllCarsUseCase', () {
    late MockCarRepository mockCarRepository;
    late GetAllCarsUseCase useCase;

    setUp(() {
      mockCarRepository = MockCarRepository();
      useCase = GetAllCarsUseCase(mockCarRepository);
    });

    test('calls getAllCars on repository and returns the result', () {
      final cars = [
        CarEntity(
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
        ),
      ];

      when(mockCarRepository.getAllCars()).thenReturn(cars);

      final result = useCase.call();

      expect(result, cars);
      verify(mockCarRepository.getAllCars()).called(1);
    });
  });
}
