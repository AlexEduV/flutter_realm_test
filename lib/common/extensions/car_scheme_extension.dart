import 'package:realm/realm.dart' show ObjectId;

import '../../data/dto/car_dto.dart';
import '../../data/models/scheme.dart';
import '../../domain/entities/car_entity.dart';

extension CarExtensions on Car {
  CarEntity toEntity() {
    return CarEntity(
      carId: carId,
      model: model ?? '',
      manufacturer: manufacturer,
      type: type,
      isVerified: isChecked ?? false,
      isHotPromotion: isHotProposition ?? false,
      year: year,
      kilometers: kilometers,
      distanceTo: distanceTo,
      price: price,
      fuelType: fuelType ?? '',
      bodyType: bodyType ?? '',
      transmissionType: transmissionType ?? '',
    );
  }

  static Car fromDto(CarDto dto) {
    return Car(
      dto.id,
      dto.carId,
      dto.manufacturer,
      dto.type,
      model: dto.model,
      year: dto.year,
      isChecked: dto.isVerified,
      isHotProposition: dto.isHotPromotion,
      kilometers: dto.kilometers,
      distanceTo: dto.distanceTo,
      price: dto.price ?? 0,
      bodyType: dto.bodyType,
      fuelType: dto.fuelType,
      transmissionType: dto.transmissionType,
    );
  }

  static Car fromEntity(CarEntity entity) {
    return Car(
      ObjectId(),
      entity.carId,
      entity.manufacturer,
      entity.type,
      model: entity.model,
      year: entity.year,
      isChecked: entity.isVerified,
      isHotProposition: entity.isHotPromotion,
      kilometers: entity.kilometers,
      distanceTo: entity.distanceTo,
      price: entity.price ?? 0,
      bodyType: entity.bodyType,
      fuelType: entity.fuelType,
      transmissionType: entity.transmissionType,
    );
  }
}
