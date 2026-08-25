import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/common/enums/body_type.dart';
import 'package:test_flutter_project/common/enums/fuel_type.dart';
import 'package:test_flutter_project/common/enums/transmission_type.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/entities/engine_entity.dart';
import 'package:test_flutter_project/domain/usecases/database/get_car_by_id_use_case.dart';

import '../../repositories/car_repository_test.mocks.dart';

void main() {
  group('GetCarByIdUseCase', () {
    late MockCarRepository mockCarRepository;
    late GetCarByIdUseCase useCase;

    setUp(() {
      mockCarRepository = MockCarRepository();
      useCase = GetCarByIdUseCase(mockCarRepository);
    });

    test('calls getCarById on repository and returns the result', () {
      final cars = [
        CarEntity(
          carId: '1',
          model: 'Model S',
          manufacturer: 'Tesla',
          type: 'car',
          isVerified: true,
          year: '2022',
          mileage: 1000,
          distanceTo: 5,
          price: 90000,
          engine: EngineEntity(type: FuelType.ev.name),
          bodyType: BodyType.sedan.name,
          transmissionType: TransmissionType.automatic.name,
        ),
      ];

      when(mockCarRepository.getCarById('1')).thenReturn(cars.first);

      final result = useCase.call('1');

      expect(result, cars.first);
      verify(mockCarRepository.getCarById('1')).called(1);
    });
  });
}
