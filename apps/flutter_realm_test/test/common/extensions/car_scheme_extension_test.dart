import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/common/enums/body_type.dart';
import 'package:test_flutter_project/common/enums/car_type.dart';
import 'package:test_flutter_project/common/enums/fuel_type.dart';
import 'package:test_flutter_project/common/enums/promo_type.dart';
import 'package:test_flutter_project/common/enums/transmission_type.dart';
import 'package:test_flutter_project/data/models/car_scheme_extension.dart';
import 'package:test_flutter_project/data/models/scheme.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/entities/engine_entity.dart';

void main() {
  group('CarExtensions', () {
    test('toEntity should convert Car to CarEntity correctly', () {
      final car = Car(
        'car123',
        'Toyota',
        CarType.car.name,
        model: 'Corolla',
        year: '2020',
        isChecked: true,
        mileage: 15000,
        distanceTo: 10,
        price: 20000,
      );

      final entity = car.toEntity();

      expect(entity.carId, 'car123');
      expect(entity.model, 'Corolla');
      expect(entity.manufacturer, 'Toyota');
      expect(entity.type, CarType.car.name);
      expect(entity.isVerified, true);
      expect(entity.promoType, isNull);
      expect(entity.year, '2020');
      expect(entity.mileage, 15000);
      expect(entity.distanceTo, 10);
      expect(entity.price, 20000);
    });

    test('fromEntity should convert CarEntity to Car correctly', () {
      final entity = CarEntity(
        carId: 'car789',
        model: 'Model S',
        manufacturer: 'Tesla',
        type: CarType.car.name,
        isVerified: true,
        promoType: PromoType.fromCode('one_owner'),
        year: '2022',
        mileage: 5000,
        distanceTo: 2,
        price: 90000,
        bodyType: BodyType.sedan.name,
        engine: EngineEntity(type: FuelType.ev.name),
        transmissionType: TransmissionType.automatic.name,
      );

      final car = CarExtensions.fromEntity(entity);

      expect(car.carId, 'car789');
      expect(car.model, 'Model S');
      expect(car.manufacturer, 'Tesla');
      expect(car.type, CarType.car.name);
      expect(car.isChecked, true);
      expect(car.hotPromotionDescription, 'one_owner');
      expect(car.year, '2022');
      expect(car.mileage, 5000);
      expect(car.distanceTo, 2);
      expect(car.price, 90000);
      expect(car.engine?.fuelType, 'ev');
      expect(car.bodyType, 'sedan');
      expect(car.transmissionType, 'automatic');
    });
  });
}
