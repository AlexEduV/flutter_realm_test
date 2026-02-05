import 'package:realm/realm.dart';

class CarDto {
  final ObjectId id;
  final String carId;
  final String model;
  final String manufacturer;
  final String type;
  final String? year;
  final String bodyType;
  final String fuelType;
  final String transmissionType;
  final String? owner;
  final bool isVerified;
  final bool isHotPromotion;
  int? kilometers;
  int? distanceTo;
  int? price;

  CarDto({
    required this.id,
    required this.carId,
    required this.model,
    required this.manufacturer,
    required this.isVerified,
    required this.isHotPromotion,
    required this.type,
    required this.bodyType,
    required this.fuelType,
    required this.transmissionType,
    this.year,
    this.owner,
    this.kilometers = 0,
    this.distanceTo,
    this.price = 0,
  });

  factory CarDto.fromJson(Map<String, dynamic> json) => CarDto(
    id: ObjectId(),
    carId: json['id'] as String,
    model: json['model'] as String,
    type: json['type'] as String,
    manufacturer: json['manufacturer'] as String,
    year: json['year'] as String?,
    isVerified: json['is_verified'] as bool,
    price: json['price'] as int?,
    isHotPromotion: json['is_hot_promotion'] as bool,
    transmissionType: json['transmission_type'] as String,
    fuelType: json['fuel_type'] as String,
    bodyType: json['body_type'] as String,
  );
}
