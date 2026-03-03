import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/entities/user_entity_short.dart';

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
      favoriteIds: entity.favoriteIds,
      lastSeenCar: _getLastSeenCar(entity.lastSeenCar),
    );
  }

  static LastSeenCar? _getLastSeenCar(Map<DateTime, String>? data) {
    if (data == null) {
      return null;
    }

    return LastSeenCar(data.entries.first.key, carId: data.entries.first.value);
  }

  static User fromUserEntityShort(UserEntityShort entity) {
    return User(
      entity.userId,
      entity.firstName,
      entity.lastName,
      entity.email,
      entity.password,
      //todo: might be a bug in future, since I am using defaults, not exact user data
      true,
      favoriteIds: [],
      lastSeenCar: null,
    );
  }
}
