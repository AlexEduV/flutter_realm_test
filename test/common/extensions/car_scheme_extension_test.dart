import 'package:flutter_test/flutter_test.dart';
import 'package:realm/realm.dart';
import 'package:test_futter_project/common/enums/body_type.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/fuel_type.dart';
import 'package:test_futter_project/common/enums/transmission_type.dart';
import 'package:test_futter_project/common/extensions/car_scheme_extension.dart';
import 'package:test_futter_project/data/dto/car_dto.dart';
import 'package:test_futter_project/data/models/scheme.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';

void main() {
  group('CarExtensions', () {
    test('toEntity should convert Car to CarEntity correctly', () {
      final car = Car(
        ObjectId(),
        'car123',
        'Toyota',
        CarType.car.name,
        model: 'Corolla',
        year: '2020',
        isChecked: true,
        kilometers: 15000,
        distanceTo: 10,
        price: 20000,
      );

      final entity = car.toEntity();

      expect(entity.carId, 'car123');
      expect(entity.model, 'Corolla');
      expect(entity.manufacturer, 'Toyota');
      expect(entity.type, CarType.car.name);
      expect(entity.isVerified, true);
      expect(entity.hotPromotionDescription, isNull);
      expect(entity.year, '2020');
      expect(entity.kilometers, 15000);
      expect(entity.distanceTo, 10);
      expect(entity.price, 20000);
    });

    test('fromDto should convert CarDto to Car correctly', () {
      final dto = CarDto(
        id: ObjectId(),
        carId: 'car456',
        model: 'CBR',
        manufacturer: 'Honda',
        type: CarType.bike.name,
        year: '2018',
        isVerified: false,
        hotPromotionDescription: 'Hot Promotion',
        kilometers: 8000,
        distanceTo: 5,
        price: 7500,
        bodyType: BodyType.bike.name,
        fuelType: FuelType.gasoline.name,
        transmissionType: TransmissionType.automatic.name,
      );

      final car = CarExtensions.fromDto(dto);

      expect(car.carId, 'car456');
      expect(car.model, 'CBR');
      expect(car.manufacturer, 'Honda');
      expect(car.type, CarType.bike.name);
      expect(car.isChecked, false);
      expect(car.hotPromotionDescription, 'Hot Promotion');
      expect(car.year, '2018');
      expect(car.kilometers, 8000);
      expect(car.distanceTo, 5);
      expect(car.price, 7500);
      expect(car.fuelType, 'gasoline');
      expect(car.bodyType, 'bike');
      expect(car.transmissionType, 'automatic');
    });

    test('fromEntity should convert CarEntity to Car correctly', () {
      final entity = CarEntity(
        carId: 'car789',
        model: 'Model S',
        manufacturer: 'Tesla',
        type: CarType.car.name,
        isVerified: true,
        hotPromotionDescription: 'Hot Promotion',
        year: '2022',
        kilometers: 5000,
        distanceTo: 2,
        price: 90000,
        bodyType: BodyType.sedan.name,
        fuelType: FuelType.ev.name,
        transmissionType: TransmissionType.automatic.name,
      );

      final car = CarExtensions.fromEntity(entity);

      expect(car.carId, 'car789');
      expect(car.model, 'Model S');
      expect(car.manufacturer, 'Tesla');
      expect(car.type, CarType.car.name);
      expect(car.isChecked, true);
      expect(car.hotPromotionDescription, 'Hot Promotion');
      expect(car.year, '2022');
      expect(car.kilometers, 5000);
      expect(car.distanceTo, 2);
      expect(car.price, 90000);
      expect(car.fuelType, 'ev');
      expect(car.bodyType, 'sedan');
      expect(car.transmissionType, 'automatic');
    });
  });
}
