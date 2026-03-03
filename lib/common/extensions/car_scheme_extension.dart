import 'package:realm/realm.dart' show ObjectId;
import 'package:test_futter_project/common/enums/promo_type.dart';
import 'package:test_futter_project/domain/models/owner_model.dart';

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
      promoType: PromoType.fromCode(hotPromotionDescription),
      year: year,
      kilometers: kilometers,
      distanceTo: distanceTo,
      price: price,
      fuelType: fuelType ?? '',
      bodyType: bodyType ?? '',
      transmissionType: transmissionType ?? '',
      owner: OwnerModel(
        id: owner?.id ?? '0',
        name: owner?.name ?? '',
        linkedItemIds: owner?.linkedIds ?? [],
      ),
      color: color,
      images: images,
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
      hotPromotionDescription: dto.promoType?.name,
      kilometers: dto.kilometers,
      distanceTo: dto.distanceTo,
      price: dto.price ?? 0,
      bodyType: dto.bodyType,
      fuelType: dto.fuelType,
      transmissionType: dto.transmissionType,
      owner: Person(
        dto.owner?.name ?? '',
        dto.owner?.id ?? '',
        linkedIds: dto.owner?.linkedItemIds ?? [],
      ),
      color: dto.color,
      images: dto.images,
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
      hotPromotionDescription: entity.promoType?.name,
      kilometers: entity.kilometers,
      distanceTo: entity.distanceTo,
      price: entity.price ?? 0,
      bodyType: entity.bodyType,
      fuelType: entity.fuelType,
      transmissionType: entity.transmissionType,
      owner: Person(
        entity.owner?.name ?? '',
        entity.owner?.id ?? '',
        linkedIds: entity.owner?.linkedItemIds ?? [],
      ),
      color: entity.color,
      images: entity.images,
    );
  }
}
