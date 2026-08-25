import 'package:test_flutter_project/common/enums/promo_type.dart';
import 'package:test_flutter_project/domain/entities/engine_entity.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';

import '../../domain/entities/car_entity.dart';
import 'scheme.dart';

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
      mileage: mileage,
      distanceTo: distanceTo,
      price: price,
      engine: EngineEntity(volume: engine?.volume, type: engine?.fuelType),
      bodyType: bodyType ?? '',
      transmissionType: transmissionType ?? '',
      owner: OwnerEntity(
        id: owner?.id ?? '0',
        firstName: owner?.firstName ?? '',
        lastName: owner?.lastName ?? '',
        linkedItemIds: owner?.linkedIds ?? [],
        imageSrc: owner?.imageSrc,
      ),
      color: color,
      images: images,
    );
  }

  static Car fromEntity(CarEntity entity) {
    return Car(
      entity.carId,
      entity.manufacturer,
      entity.type,
      model: entity.model,
      year: entity.year,
      isChecked: entity.isVerified,
      hotPromotionDescription: entity.promoType?.code,
      mileage: entity.mileage,
      distanceTo: entity.distanceTo,
      price: entity.price ?? 0,
      bodyType: entity.bodyType,
      engine: Engine(volume: entity.engine.volume, fuelType: entity.engine.type),
      transmissionType: entity.transmissionType,
      owner: Person(
        entity.owner?.firstName ?? '',
        entity.owner?.lastName ?? '',
        entity.owner?.id ?? '',
        linkedIds: entity.owner?.linkedItemIds ?? [],
        imageSrc: entity.owner?.imageSrc,
      ),
      color: entity.color,
      images: entity.images,
    );
  }
}
