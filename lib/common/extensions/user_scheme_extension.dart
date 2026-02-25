import 'package:test_futter_project/common/extensions/car_scheme_extension.dart';
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
      entity.isLocationPermissionGranted,
      favoriteIds: entity.favoriteIds,
      lastSeenCar: entity.lastSeenCar == null
          ? null
          : LastSeenCar(
              entity.lastSeenCar!.entries.first.key,
              car: CarExtensions.fromEntity(entity.lastSeenCar!.entries.first.value),
            ),
    );
  }

  static User fromUserEntityShort(UserEntityShort entity) {
    return User(
      entity.userId,
      entity.firstName,
      entity.lastName,
      entity.email,
      //todo: might be a bug in future, since I am using defaults, not exact user data
      true,
      favoriteIds: [],
      lastSeenCar: null,
    );
  }
}
