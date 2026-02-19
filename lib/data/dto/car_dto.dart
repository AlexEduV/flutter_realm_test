import 'package:realm/realm.dart';
import 'package:test_futter_project/domain/models/owner_model.dart';

class CarDto {
  final ObjectId id;
  final String carId;
  final String model;
  final String manufacturer;
  final String type;
  final String? year;
  final String? color;
  final String bodyType;
  final String fuelType;
  final String transmissionType;
  final OwnerModel? owner;
  final bool isVerified;
  final String? hotPromotionDescription;
  int? kilometers;
  int? distanceTo;
  int? price;
  List<String> images;

  CarDto({
    required this.id,
    required this.carId,
    required this.model,
    required this.manufacturer,
    required this.isVerified,
    required this.type,
    required this.bodyType,
    required this.fuelType,
    required this.transmissionType,
    this.hotPromotionDescription,
    this.color,
    this.year,
    this.owner,
    this.kilometers = 0,
    this.distanceTo,
    this.price = 0,
    this.images = const [],
  });

  factory CarDto.fromJson(Map<String, dynamic> json) {
    return CarDto(
      id: ObjectId(),
      carId: json['id'] as String,
      model: json['model'] as String,
      type: json['type'] as String,
      manufacturer: json['manufacturer'] as String,
      year: json['year'] as String?,
      isVerified: json['is_verified'] as bool,
      price: json['price'] as int?,
      hotPromotionDescription: json['hot_promotion_description'] as String?,
      transmissionType: json['transmission_type'] as String,
      fuelType: json['fuel_type'] as String,
      bodyType: json['body_type'] as String,
      color: json['color'] as String,
      owner: OwnerModel.fromJson(json['owner'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }
}
