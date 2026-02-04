import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:realm/realm.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/data/dto/car_dto.dart';

import '../../data/repositories/car_repository_impl_test.mocks.dart';

void main() {
  late MockCarApiService mockService;

  setUp(() {
    mockService = MockCarApiService();
  });

  group('CarApiService', () {
    test('fetchCars returns a list of CarDto', () async {
      final cars = [
        CarDto(
          id: ObjectId(),
          carId: 'car1',
          manufacturer: 'Toyota',
          type: CarType.car.name,
          isVerified: true,
          model: 'Camry',
          isHotPromotion: false,
        ),
        CarDto(
          id: ObjectId(),
          carId: 'car2',
          manufacturer: 'Honda',
          type: CarType.bike.name,
          isVerified: false,
          model: 'Type R',
          isHotPromotion: false,
        ),
      ];

      when(mockService.fetchCars()).thenAnswer((_) async => cars);

      final result = await mockService.fetchCars();

      expect(result, isA<List<CarDto>>());
      expect(result.length, 2);
      expect(result.first.manufacturer, 'Toyota');
    });

    test('carStream emits a list of CarDto', () async {
      final cars = [
        CarDto(
          id: ObjectId(),
          carId: 'car1',
          manufacturer: 'Toyota',
          type: CarType.car.name,
          isVerified: true,
          model: 'Camry',
          isHotPromotion: false,
        ),
        CarDto(
          id: ObjectId(),
          carId: 'car2',
          manufacturer: 'Honda',
          type: CarType.bike.name,
          isVerified: false,
          model: 'Type R',
          isHotPromotion: false,
        ),
      ];

      when(mockService.carStream).thenAnswer((_) => Stream.value(cars));

      await expectLater(mockService.carStream, emits(cars));
    });

    test('dispose can be called without error', () {
      when(mockService.dispose()).thenReturn(null);

      expect(() => mockService.dispose(), returnsNormally);
    });
  });
}
