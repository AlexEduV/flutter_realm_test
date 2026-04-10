import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/common/enums/body_type.dart';
import 'package:test_futter_project/common/enums/fuel_type.dart';
import 'package:test_futter_project/common/enums/transmission_type.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/usecases/database/watch_cars_use_case.dart';

import '../../repositories/car_repository_test.mocks.dart';

void main() {
  group('WatchCarsUseCase', () {
    late MockCarRepository mockCarRepository;
    late WatchCarsUseCase useCase;

    setUp(() {
      mockCarRepository = MockCarRepository();
      useCase = WatchCarsUseCase(mockCarRepository);
    });

    test('calls watchCars on repository and returns the stream', () {
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
      final stream = Stream<List<CarEntity>>.value(cars);

      when(mockCarRepository.watchCars()).thenAnswer((_) => stream);

      final result = useCase.call();

      expect(result, isA<Stream<List<CarEntity>>>());
      expect(result, stream);
      verify(mockCarRepository.watchCars()).called(1);
    });
  });
}
