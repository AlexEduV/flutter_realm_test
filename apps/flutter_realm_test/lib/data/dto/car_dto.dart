import 'package:realm/realm.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/entities/engine_entity.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';

import '../../common/enums/promo_type.dart';

class CarDto {
  final ObjectId id;
  final String carId;
  final String model;
  final String manufacturer;
  final String type;
  final String? year;
  final String? color;
  final String bodyType;
  final EngineEntity engine;
  final String transmissionType;
  final OwnerEntity? owner;
  final bool isVerified;
  final PromoType? promoType;
  int? mileage;
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
    required this.engine,
    required this.transmissionType,
    this.promoType,
    this.color,
    this.year,
    this.owner,
    this.mileage = 0,
    this.distanceTo,
    this.price = 0,
    this.images = const [],
  });

  CarDto copyWith({
    ObjectId? id,
    String? carId,
    String? model,
    String? manufacturer,
    String? type,
    String? year,
    String? color,
    String? bodyType,
    EngineEntity? engine,
    String? transmissionType,
    OwnerEntity? owner,
    bool? isVerified,
    PromoType? promoType,
    int? mileage,
    int? distanceTo,
    int? price,
    List<String>? images,
  }) {
    return CarDto(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      model: model ?? this.model,
      manufacturer: manufacturer ?? this.manufacturer,
      type: type ?? this.type,
      year: year ?? this.year,
      color: color ?? this.color,
      bodyType: bodyType ?? this.bodyType,
      engine: engine ?? this.engine,
      transmissionType: transmissionType ?? this.transmissionType,
      owner: owner ?? this.owner,
      isVerified: isVerified ?? this.isVerified,
      promoType: promoType ?? this.promoType,
      mileage: mileage ?? this.mileage,
      distanceTo: distanceTo ?? this.distanceTo,
      price: price ?? this.price,
      images: images ?? this.images,
    );
  }

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
      promoType: PromoType.fromCode(json['promo_type'] as String?),
      transmissionType: json['transmission_type'] as String,
      engine: EngineEntity.fromJson(json['engine'] as Map<String, dynamic>),
      bodyType: json['body_type'] as String,
      color: json['color'] as String,
      owner: OwnerEntity.fromJson(json['owner'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      mileage: json['mileage'] as int?,
    );
  }

  factory CarDto.fromEntity(CarEntity entity) {
    return CarDto(
      id: entity.id,
      carId: entity.carId,
      model: entity.model,
      manufacturer: entity.manufacturer,
      isVerified: entity.isVerified,
      type: entity.type,
      bodyType: entity.bodyType,
      engine: entity.engine,
      transmissionType: entity.transmissionType,
    );
  }
}
