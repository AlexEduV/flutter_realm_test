import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/common/enums/body_type.dart';
import 'package:test_flutter_project/common/enums/fuel_type.dart';
import 'package:test_flutter_project/common/enums/transmission_type.dart';
import 'package:test_flutter_project/data/dto/car_dto.dart';
import 'package:test_flutter_project/domain/entities/engine_entity.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';

void main() {
  group('CarDto', () {
    test('constructor sets all fields correctly', () {
      final car = CarDto(
        carId: '123',
        model: 'Model S',
        manufacturer: 'Tesla',
        type: 'car',
        isVerified: true,
        year: '2020',
        owner: OwnerEntity(id: 'test', firstName: 'John', lastName: 'Doe', linkedItemIds: []),
        mileage: 10000,
        distanceTo: 50,
        price: 80000,
        engine: EngineEntity(type: FuelType.ev.name),
        transmissionType: TransmissionType.automatic.name,
        bodyType: BodyType.sedan.name,
      );

      expect(car.carId, '123');
      expect(car.model, 'Model S');
      expect(car.manufacturer, 'Tesla');
      expect(car.type, 'car');
      expect(car.isVerified, true);
      expect(car.promoType, isNull);
      expect(car.year, '2020');
      expect(car.owner?.firstName ?? '', 'John');
      expect(car.owner?.lastName ?? '', 'Doe');
      expect(car.mileage, 10000);
      expect(car.distanceTo, 50);
      expect(car.price, 80000);
      expect(car.engine.type, 'ev');
      expect(car.transmissionType, 'automatic');
      expect(car.bodyType, 'sedan');
    });

    test('default values for optional fields', () {
      final car = CarDto(
        carId: '123',
        model: 'Model S',
        manufacturer: 'Tesla',
        isVerified: true,
        type: 'car',
        bodyType: 'sedan',
        engine: EngineEntity(type: FuelType.ev.name),
        transmissionType: 'manual',
      );

      expect(car.year, isNull);
      expect(car.owner, isNull);
      expect(car.mileage, 0);
      expect(car.distanceTo, isNull);
      expect(car.price, 0);
    });
  });
}
