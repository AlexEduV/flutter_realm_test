import 'package:flutter_test/flutter_test.dart';
import 'package:realm/realm.dart';
import 'package:test_flutter_project/common/enums/body_type.dart';
import 'package:test_flutter_project/common/enums/fuel_type.dart';
import 'package:test_flutter_project/common/enums/promo_type.dart';
import 'package:test_flutter_project/common/enums/transmission_type.dart';
import 'package:test_flutter_project/data/dto/car_dto.dart';
import 'package:test_flutter_project/data/models/scheme.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';

void main() {
  final mockCar = Car(
    ObjectId(),
    'car123',
    'Tesla',
    'car',
    model: 'Model S',
    isChecked: true,
    hotPromotionDescription: null,
    price: 80000,
    distanceTo: 50,
    year: '2020',
    owner: Person('John', 'Doe', 'test', linkedIds: []),
    kilometers: 10000,
    bodyType: 'sedan',
    fuelType: 'ev',
    transmissionType: 'automatic',
    color: 'White',
    images: [],
  );

  group('CarEntity', () {
    test('constructor sets all fields correctly', () {
      final entity = CarEntity(
        carId: 'car123',
        model: 'Model S',
        manufacturer: 'Tesla',
        isVerified: true,
        type: 'car',
        year: '2020',
        owner: OwnerEntity(id: 'test', firstName: 'John', lastName: 'Doe', linkedItemIds: []),
        kilometers: 10000,
        distanceTo: 50,
        price: 80000,
        fuelType: FuelType.ev.name,
        bodyType: BodyType.sedan.name,
        transmissionType: TransmissionType.automatic.name,
      );

      expect(entity.carId, 'car123');
      expect(entity.model, 'Model S');
      expect(entity.manufacturer, 'Tesla');
      expect(entity.isVerified, true);
      expect(entity.promoType, null);
      expect(entity.year, '2020');
      expect(entity.owner?.firstName, 'John');
      expect(entity.owner?.lastName, 'Doe');
      expect(entity.kilometers, 10000);
      expect(entity.distanceTo, 50);
      expect(entity.price, 80000);
      expect(entity.fuelType, 'ev');
      expect(entity.bodyType, 'sedan');
      expect(entity.transmissionType, 'automatic');
    });

    test('fromDto factory creates instance with correct values', () {
      final dto = CarDto(
        id: ObjectId(),
        carId: 'car456',
        model: 'Civic',
        manufacturer: 'Honda',
        type: 'car',
        isVerified: false,
        promoType: PromoType.oneOwner,
        year: '2018',
        owner: OwnerEntity(id: 'test', firstName: 'Jane', lastName: 'Doe', linkedItemIds: []),
        kilometers: 50000,
        distanceTo: 100,
        price: 20000,
        fuelType: FuelType.gasoline.name,
        bodyType: BodyType.sedan.name,
        transmissionType: TransmissionType.automatic.name,
      );

      final entity = CarEntity.fromDto(dto);

      expect(entity.carId, 'car456');
      expect(entity.model, 'Civic');
      expect(entity.manufacturer, 'Honda');
      expect(entity.isVerified, false);
      expect(entity.promoType, PromoType.oneOwner);
      expect(entity.year, '2018');
      expect(entity.owner?.firstName, 'Jane');
      expect(entity.owner?.lastName, 'Doe');
      expect(entity.kilometers, 50000);
      expect(entity.distanceTo, 100);
      expect(entity.price, 20000);
      expect(entity.fuelType, 'gasoline');
      expect(entity.bodyType, 'sedan');
      expect(entity.transmissionType, 'automatic');
    });

    test('fromSchema factory creates instance with correct values', () {
      final entity = CarEntity.fromSchema(mockCar);

      expect(entity.carId, 'car123');
      expect(entity.model, 'Model S');
      expect(entity.manufacturer, 'Tesla');
      expect(entity.isVerified, true);
      expect(entity.promoType, null);
      expect(entity.year, '2020');
      expect(entity.owner?.firstName, 'John');
      expect(entity.owner?.lastName, 'Doe');
      expect(entity.kilometers, 10000);
      expect(entity.distanceTo, 50);
      expect(entity.price, 80000);
      expect(entity.fuelType, 'ev');
      expect(entity.bodyType, 'sedan');
      expect(entity.transmissionType, 'automatic');
    });

    test('fromSchema handles nulls and defaults', () {
      mockCar.model = null;
      mockCar.isChecked = null;
      mockCar.hotPromotionDescription = null;

      final entity = CarEntity.fromSchema(mockCar);

      expect(entity.model, ''); // default for null model
      expect(entity.isVerified, false); // default for null isChecked
      expect(entity.promoType, isNull); // default for null isHotProposition
      expect(entity.owner?.firstName, 'John'); // default for null owner
      expect(entity.owner?.lastName, 'Doe'); // default for null owner
    });

    test('hashCode returns the same value for equal objects', () {
      final entity1 = CarEntity(
        carId: 'car123',
        model: 'Model S',
        manufacturer: 'Tesla',
        isVerified: true,
        type: 'car',
        year: '2020',
        owner: OwnerEntity(id: 'test', firstName: 'John', lastName: 'Doe', linkedItemIds: []),
        kilometers: 10000,
        distanceTo: 50,
        price: 80000,
        fuelType: FuelType.ev.name,
        bodyType: BodyType.sedan.name,
        transmissionType: TransmissionType.automatic.name,
      );

      final entity2 = CarEntity(
        carId: 'car123',
        model: 'Model S',
        manufacturer: 'Tesla',
        isVerified: true,
        type: 'car',
        year: '2020',
        owner: OwnerEntity(id: 'test', firstName: 'John', lastName: 'Doe', linkedItemIds: []),
        kilometers: 10000,
        distanceTo: 50,
        price: 80000,
        fuelType: FuelType.ev.name,
        bodyType: BodyType.sedan.name,
        transmissionType: TransmissionType.automatic.name,
      );

      expect(entity1, equals(entity2));
      expect(entity1.hashCode, equals(entity2.hashCode));
    });

    test('hashCode returns different values for different objects', () {
      final entity1 = CarEntity(
        carId: 'car123',
        model: 'Model S',
        manufacturer: 'Tesla',
        isVerified: true,
        type: 'car',
        year: '2020',
        owner: OwnerEntity(id: 'test', firstName: 'John', lastName: 'Doe', linkedItemIds: []),
        kilometers: 10000,
        distanceTo: 50,
        price: 80000,
        fuelType: FuelType.ev.name,
        bodyType: BodyType.sedan.name,
        transmissionType: TransmissionType.automatic.name,
      );

      final entity2 = CarEntity(
        carId: 'car456', // different carId
        model: 'Model 3',
        manufacturer: 'Tesla',
        isVerified: false,
        type: 'car',
        year: '2021',
        owner: OwnerEntity(id: 'test2', firstName: 'Jane', lastName: 'Doe', linkedItemIds: []),
        kilometers: 5000,
        distanceTo: 100,
        price: 40000,
        fuelType: FuelType.gasoline.name,
        bodyType: BodyType.crossover.name,
        transmissionType: TransmissionType.manual.name,
      );

      expect(entity1, isNot(equals(entity2)));
      expect(entity1.hashCode, isNot(equals(entity2.hashCode)));
    });
  });
}
