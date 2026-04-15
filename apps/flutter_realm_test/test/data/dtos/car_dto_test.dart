import 'package:flutter_test/flutter_test.dart';
import 'package:realm/realm.dart';
import 'package:test_flutter_project/common/enums/body_type.dart';
import 'package:test_flutter_project/common/enums/fuel_type.dart';
import 'package:test_flutter_project/common/enums/promo_type.dart';
import 'package:test_flutter_project/common/enums/transmission_type.dart';
import 'package:test_flutter_project/data/dto/car_dto.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';

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
        year: '2020',
        owner: OwnerEntity(id: 'test', firstName: 'John', lastName: 'Doe', linkedItemIds: []),
        kilometers: 10000,
        distanceTo: 50,
        price: 80000,
        fuelType: FuelType.ev.name,
        transmissionType: TransmissionType.automatic.name,
        bodyType: BodyType.sedan.name,
      );

      expect(car.id, id);
      expect(car.carId, '123');
      expect(car.model, 'Model S');
      expect(car.manufacturer, 'Tesla');
      expect(car.type, 'car');
      expect(car.isVerified, true);
      expect(car.promoType, isNull);
      expect(car.year, '2020');
      expect(car.owner?.firstName ?? '', 'John');
      expect(car.owner?.lastName ?? '', 'Doe');
      expect(car.kilometers, 10000);
      expect(car.distanceTo, 50);
      expect(car.price, 80000);
      expect(car.fuelType, 'ev');
      expect(car.transmissionType, 'automatic');
      expect(car.bodyType, 'sedan');
    });

    test('default values for optional fields', () {
      final id = ObjectId();
      final car = CarDto(
        id: id,
        carId: '123',
        model: 'Model S',
        manufacturer: 'Tesla',
        isVerified: true,
        type: 'car',
        bodyType: 'sedan',
        fuelType: 'ev',
        transmissionType: 'manual',
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
        'promo_type': 'one_owner',
        'type': 'car',
        'body_type': 'sedan',
        'transmission_type': 'automatic',
        'fuel_type': 'ev',
        'owner': {
          'first_name': 'James',
          'last_name': 'Morrison',
          'id': '4',
          'linked_ids': <String>[],
        },
        'color': 'White',
        'images': [],
      };

      final car = CarDto.fromJson(json);

      expect(car.carId, '456');
      expect(car.model, 'Civic');
      expect(car.manufacturer, 'Honda');
      expect(car.year, '2018');
      expect(car.isVerified, false);
      expect(car.price, 20000);
      expect(car.promoType, PromoType.oneOwner);
      expect(car.id, isA<ObjectId>());
    });
  });
}
