import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/extensions/user_scheme_extension.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';

void main() {
  group('UserExtensions', () {
    test('fromEntity should convert UserEntity to User correctly', () {
      final entity = const UserEntity(
        userId: 'user123',
        firstName: 'John',
        lastName: 'Doe',
        isLocationPermissionGranted: true,
      );

      final user = UserExtensions.fromEntity(entity);

      expect(user.userId, 'user123');
      expect(user.firstName, 'John');
      expect(user.lastName, 'Doe');
      expect(user.isLocationPermissionGranted, true);
    });
  });
}
