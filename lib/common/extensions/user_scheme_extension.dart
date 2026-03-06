import 'package:test_futter_project/domain/entities/user_entity.dart';

import '../../data/models/scheme.dart';

extension UserExtensions on User {
  static User fromEntity(UserEntity entity) {
    return User(
      entity.userId,
      entity.firstName,
      entity.lastName,
      entity.email,
      entity.password,
      entity.isLocationPermissionGranted,
      entity.region,
      favoriteIds: entity.favoriteIds,
      viewedIds: entity.viewedIds,
      lastSeenCar: _getLastSeenCar(entity.lastSeenCar),
      avatarImage: entity.avatarImageSrc,
    );
  }

  static LastSeenCar? _getLastSeenCar(Map<DateTime, String>? data) {
    if (data == null) {
      return null;
    }

    return LastSeenCar(data.entries.first.key, carId: data.entries.first.value);
  }
}
