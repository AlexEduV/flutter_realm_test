import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:realm/realm.dart';
import 'package:test_futter_project/data/dto/car_dto.dart';
import 'package:test_futter_project/data/models/scheme.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';

import '../../data/repositories/car_repository_impl_test.mocks.dart';

void main() {
  final mockCar = MockCar();

  setUpAll(() {
    when(mockCar.carId).thenReturn('car123');
    when(mockCar.model).thenReturn('Model S');
    when(mockCar.manufacturer).thenReturn('Tesla');
    when(mockCar.isChecked).thenReturn(true);
    when(mockCar.isHotProposition).thenReturn(false);
    when(mockCar.price).thenReturn(80000);
    when(mockCar.distanceTo).thenReturn(50);
    when(mockCar.year).thenReturn('2020');
    when(mockCar.owner).thenReturn(Person('John Doe'));
    when(mockCar.kilometers).thenReturn(10000);
    when(mockCar.type).thenReturn('car');
  });

  group('CarEntity', () {
    test('constructor sets all fields correctly', () {
      final entity = CarEntity(
        carId: 'car123',
        model: 'Model S',
        manufacturer: 'Tesla',
        isVerified: true,
        isHotPromotion: false,
        type: 'car',
        year: '2020',
        owner: 'John Doe',
        kilometers: 10000,
        distanceTo: 50,
        price: 80000,
      );

      expect(entity.carId, 'car123');
      expect(entity.model, 'Model S');
      expect(entity.manufacturer, 'Tesla');
      expect(entity.isVerified, true);
      expect(entity.isHotPromotion, false);
      expect(entity.year, '2020');
      expect(entity.owner, 'John Doe');
      expect(entity.kilometers, 10000);
      expect(entity.distanceTo, 50);
      expect(entity.price, 80000);
    });

    test('fromDto factory creates instance with correct values', () {
      final dto = CarDto(
        id: ObjectId(),
        carId: 'car456',
        model: 'Civic',
        manufacturer: 'Honda',
        type: 'car',
        isVerified: false,
        isHotPromotion: true,
        year: '2018',
        owner: 'Jane Doe',
        kilometers: 50000,
        distanceTo: 100,
        price: 20000,
      );

      final entity = CarEntity.fromDto(dto);

      expect(entity.carId, 'car456');
      expect(entity.model, 'Civic');
      expect(entity.manufacturer, 'Honda');
      expect(entity.isVerified, false);
      expect(entity.isHotPromotion, true);
      expect(entity.year, '2018');
      expect(entity.owner, 'Jane Doe');
      expect(entity.kilometers, 50000);
      expect(entity.distanceTo, 100);
      expect(entity.price, 20000);
    });

    test('fromSchema factory creates instance with correct values', () {
      final entity = CarEntity.fromSchema(mockCar);

      expect(entity.carId, 'car123');
      expect(entity.model, 'Model S');
      expect(entity.manufacturer, 'Tesla');
      expect(entity.isVerified, true);
      expect(entity.isHotPromotion, false);
      expect(entity.year, '2020');
      expect(entity.owner, 'John Doe');
      expect(entity.kilometers, 10000);
      expect(entity.distanceTo, 50);
      expect(entity.price, 80000);
    });

    test('fromSchema handles nulls and defaults', () {
      when(mockCar.model).thenReturn(null);
      when(mockCar.isChecked).thenReturn(null);
      when(mockCar.isHotProposition).thenReturn(null);

      final entity = CarEntity.fromSchema(mockCar);

      expect(entity.model, ''); // default for null model
      expect(entity.isVerified, false); // default for null isChecked
      expect(entity.isHotPromotion, false); // default for null isHotProposition
      expect(entity.owner, 'John Doe'); // default for null owner
    });
  });
}
