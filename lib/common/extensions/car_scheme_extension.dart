import 'package:realm/realm.dart' show ObjectId;

import '../../data/dto/car_dto.dart';
import '../../data/models/scheme.dart';
import '../../domain/entities/car_entity.dart';

extension CarExtensions on Car {
  CarEntity toEntity(Car car) {
    return CarEntity(
      carId: car.carId,
      model: car.model ?? '',
      manufacturer: car.manufacturer,
      isVerified: car.isChecked ?? false,
      isHotPromotion: car.isHotProposition ?? false,
      year: car.year,
      kilometers: car.kilometers,
      distanceTo: car.distanceTo,
      price: car.price,
    );
  }

  static Car fromDto(CarDto dto) {
    return Car(
      dto.id,
      dto.carId,
      dto.manufacturer,
      model: dto.model,
      year: dto.year,
      isChecked: dto.isVerified,
      isHotProposition: dto.isHotPromotion,
      kilometers: dto.kilometers,
      distanceTo: dto.distanceTo,
      price: dto.price ?? 0,
    );
  }

  static Car fromEntity(CarEntity entity) {
    return Car(
      ObjectId(),
      entity.carId,
      entity.manufacturer,
      model: entity.model,
      year: entity.year,
      isChecked: entity.isVerified,
      isHotProposition: entity.isHotPromotion,
      kilometers: entity.kilometers,
      distanceTo: entity.distanceTo,
      price: entity.price ?? 0,
    );
  }
}
