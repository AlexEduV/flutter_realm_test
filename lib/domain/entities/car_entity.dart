import 'package:test_futter_project/common/enums/body_type.dart';
import 'package:test_futter_project/common/enums/fuel_type.dart';
import 'package:test_futter_project/common/enums/promo_type.dart';
import 'package:test_futter_project/common/enums/transmission_type.dart';
import 'package:test_futter_project/domain/entities/owner_entity.dart';

import '../../data/dto/car_dto.dart';
import '../../data/models/scheme.dart';

class CarEntity {
  final String carId;
  final String model;
  final String manufacturer;
  final String type;
  final String? year;
  final String? color;
  final OwnerEntity? owner;
  final String bodyType;
  final String fuelType;
  final String transmissionType;
  final bool isVerified;
  final PromoType? promoType;
  int? kilometers = 0;
  int? distanceTo;
  int? price = 0;
  final List<String> images;
  bool isShown;

  CarEntity({
    required this.carId,
    required this.model,
    required this.manufacturer,
    required this.isVerified,
    required this.type,
    required this.bodyType,
    required this.fuelType,
    required this.transmissionType,
    this.promoType,
    this.year,
    this.color,
    this.owner,
    this.kilometers,
    this.distanceTo,
    this.price,
    this.images = const [],
    this.isShown = true,
  });

  factory CarEntity.empty() {
    return CarEntity(
      carId: 'testId',
      model: 'Test Model',
      type: 'Car',
      manufacturer: 'Test Motors',
      isVerified: true,
      bodyType: BodyType.sedan.name,
      fuelType: FuelType.gasoline.name,
      transmissionType: TransmissionType.manual.name,
      color: 'White',
    );
  }

  CarEntity copyWith({
    String? carId,
    String? model,
    String? manufacturer,
    String? type,
    String? year,
    String? color,
    OwnerEntity? owner,
    String? bodyType,
    String? fuelType,
    String? transmissionType,
    bool? isVerified,
    PromoType? promoType,
    int? kilometers,
    int? distanceTo,
    int? price,
    List<String>? images,
    bool? isShown,
  }) {
    return CarEntity(
      carId: carId ?? this.carId,
      model: model ?? this.model,
      manufacturer: manufacturer ?? this.manufacturer,
      isVerified: isVerified ?? this.isVerified,
      type: type ?? this.type,
      bodyType: bodyType ?? this.bodyType,
      fuelType: fuelType ?? this.fuelType,
      transmissionType: transmissionType ?? this.transmissionType,
      promoType: promoType ?? this.promoType,
      year: year ?? this.year,
      color: color ?? this.color,
      owner: owner ?? this.owner,
      kilometers: kilometers ?? this.kilometers,
      distanceTo: distanceTo ?? this.distanceTo,
      price: price ?? this.price,
      images: images ?? this.images,
      isShown: isShown ?? this.isShown,
    );
  }

  factory CarEntity.fromDto(CarDto dto) {
    return CarEntity(
      carId: dto.carId,
      model: dto.model,
      manufacturer: dto.manufacturer,
      isVerified: dto.isVerified,
      promoType: dto.promoType,
      type: dto.type,
      color: dto.color,
      price: dto.price,
      distanceTo: dto.distanceTo,
      year: dto.year,
      owner: dto.owner,
      kilometers: dto.kilometers,
      bodyType: dto.bodyType,
      fuelType: dto.fuelType,
      transmissionType: dto.transmissionType,
      images: dto.images,
    );
  }

  factory CarEntity.fromSchema(Car car) {
    return CarEntity(
      carId: car.carId,
      model: car.model ?? '',
      manufacturer: car.manufacturer,
      type: car.type,
      isVerified: car.isChecked ?? false,
      promoType: PromoType.fromCode(car.hotPromotionDescription),
      price: car.price,
      distanceTo: car.distanceTo,
      color: car.color,
      year: car.year,
      owner: OwnerEntity(
        id: car.owner?.id ?? '',
        firstName: car.owner?.firstName ?? '',
        lastName: car.owner?.lastName ?? '',
        linkedItemIds: car.owner?.linkedIds ?? [],
        imageSrc: car.owner?.imageSrc,
      ),
      kilometers: car.kilometers,
      fuelType: car.fuelType ?? '',
      bodyType: car.bodyType ?? '',
      transmissionType: car.transmissionType ?? '',
      images: car.images.toList(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarEntity &&
          runtimeType == other.runtimeType &&
          carId == other.carId &&
          model == other.model &&
          manufacturer == other.manufacturer &&
          type == other.type &&
          year == other.year &&
          color == other.color &&
          owner == other.owner &&
          bodyType == other.bodyType &&
          fuelType == other.fuelType &&
          transmissionType == other.transmissionType &&
          isVerified == other.isVerified &&
          promoType == other.promoType &&
          kilometers == other.kilometers &&
          distanceTo == other.distanceTo &&
          price == other.price &&
          images == other.images &&
          isShown == other.isShown;

  @override
  int get hashCode =>
      carId.hashCode ^
      model.hashCode ^
      manufacturer.hashCode ^
      type.hashCode ^
      (year?.hashCode ?? 0) ^
      (color?.hashCode ?? 0) ^
      (owner?.hashCode ?? 0) ^
      bodyType.hashCode ^
      fuelType.hashCode ^
      transmissionType.hashCode ^
      isVerified.hashCode ^
      (promoType?.hashCode ?? 0) ^
      (kilometers ?? 0).hashCode ^
      (distanceTo ?? 0).hashCode ^
      (price ?? 0).hashCode ^
      (images).hashCode ^
      isShown.hashCode;
}
