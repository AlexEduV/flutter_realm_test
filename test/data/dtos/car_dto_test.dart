import 'package:flutter_test/flutter_test.dart';
import 'package:realm/realm.dart';
import 'package:test_futter_project/data/dto/car_dto.dart';

void main() {
  group('CarDto', () {
    test('constructor sets all fields correctly', () {
      final id = ObjectId();
      final car = CarDto(
        id: id,
        carId: '123',
        model: 'Model S',
        manufacturer: 'Tesla',
        type: 'car',
        isVerified: true,
        isHotPromotion: false,
        year: '2020',
        owner: 'John Doe',
        kilometers: 10000,
        distanceTo: 50,
        price: 80000,
      );

      expect(car.id, id);
      expect(car.carId, '123');
      expect(car.model, 'Model S');
      expect(car.manufacturer, 'Tesla');
      expect(car.type, 'car');
      expect(car.isVerified, true);
      expect(car.isHotPromotion, false);
      expect(car.year, '2020');
      expect(car.owner, 'John Doe');
      expect(car.kilometers, 10000);
      expect(car.distanceTo, 50);
      expect(car.price, 80000);
    });

    test('default values for optional fields', () {
      final id = ObjectId();
      final car = CarDto(
        id: id,
        carId: '123',
        model: 'Model S',
        manufacturer: 'Tesla',
        isVerified: true,
        isHotPromotion: false,
        type: 'car',
      );

      expect(car.year, isNull);
      expect(car.owner, isNull);
      expect(car.kilometers, 0);
      expect(car.distanceTo, isNull);
      expect(car.price, 0);
    });

    test('fromJson factory creates instance with correct values', () {
      final json = {
        'id': '456',
        'model': 'Civic',
        'manufacturer': 'Honda',
        'year': '2018',
        'is_verified': false,
        'price': 20000,
        'is_hot_promotion': true,
        'type': 'car',
      };

      final car = CarDto.fromJson(json);

      expect(car.carId, '456');
      expect(car.model, 'Civic');
      expect(car.manufacturer, 'Honda');
      expect(car.year, '2018');
      expect(car.isVerified, false);
      expect(car.price, 20000);
      expect(car.isHotPromotion, true);
      expect(car.id, isA<ObjectId>());
    });
  });
}
