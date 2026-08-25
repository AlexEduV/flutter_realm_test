import 'package:test_flutter_project/domain/entities/last_seen_car_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';

import 'scheme.dart';

extension UserExtensions on User {
  static User fromEntity(UserEntity entity) {
    return User(
      entity.userId,
      entity.firstName,
      entity.lastName,
      entity.email,
      entity.password,
      entity.region,
      isLocationPermissionGranted: entity.isLocationPermissionGranted,
      favoriteIds: entity.favoriteIds,
      viewedIds: entity.viewedIds,
      createdIds: entity.createdIds,
      lastSeenCar: getLastSeenCar(entity.lastSeenCar),
      avatarImage: entity.avatarImageSrc,
    );
  }

  static LastSeenCar? getLastSeenCar(LastSeenCarEntity? entity) {
    if (entity == null) return null;
    return LastSeenCar(entity.seenAt, carId: entity.carId);
  }
}
