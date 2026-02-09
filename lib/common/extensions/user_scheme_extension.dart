import 'package:test_futter_project/domain/entities/user_entity.dart';

import '../../data/models/scheme.dart';

extension UserExtensions on User {
  static User fromEntity(UserEntity entity) {
    return User(
      entity.userId,
      entity.firstName,
      entity.lastName,
      entity.isLocationPermissionGranted,
      favoriteIds: entity.favoriteIds,
    );
  }
}
