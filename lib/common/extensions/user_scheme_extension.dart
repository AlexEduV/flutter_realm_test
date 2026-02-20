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
    );
  }

  static User fromUserEntityShort(UserEntityShort entity) {
    return User(
      entity.userId,
      entity.firstName,
      entity.lastName,
      entity.email,
      true,
      favoriteIds: [],
    );
  }
}
