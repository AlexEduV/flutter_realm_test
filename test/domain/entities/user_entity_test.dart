import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/data/models/scheme.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';

import 'user_entity_test.mocks.dart';

@GenerateMocks([User])
void main() {
  group('UserEntity', () {
    test('constructor sets all fields correctly', () {
      const entity = UserEntity(
        userId: 'u1',
        firstName: 'John',
        lastName: 'Doe',
        isLocationPermissionGranted: true,
        favoriteIds: [],
      );

      expect(entity.userId, 'u1');
      expect(entity.firstName, 'John');
      expect(entity.lastName, 'Doe');
      expect(entity.isLocationPermissionGranted, true);
    });

    test('fromSchema creates UserEntity from User', () {
      final mockUser = MockUser();
      when(mockUser.userId).thenReturn('u2');
      when(mockUser.firstName).thenReturn('Jane');
      when(mockUser.lastName).thenReturn('Smith');
      when(mockUser.isLocationPermissionGranted).thenReturn(false);

      final entity = UserEntity.fromSchema(mockUser);

      expect(entity.userId, 'u2');
      expect(entity.firstName, 'Jane');
      expect(entity.lastName, 'Smith');
      expect(entity.isLocationPermissionGranted, false);
    });

    test('copyWith returns a new UserEntity with updated fields', () {
      const original = UserEntity(
        userId: 'u3',
        firstName: 'Alice',
        lastName: 'Brown',
        isLocationPermissionGranted: false,
        favoriteIds: [],
      );

      final updated = original.copyWith(firstName: 'Alicia', isLocationPermissionGranted: true);

      expect(updated.userId, 'u3');
      expect(updated.firstName, 'Alicia');
      expect(updated.lastName, 'Brown');
      expect(updated.isLocationPermissionGranted, true);
    });

    test('copyWith returns original when no parameters are provided', () {
      const original = UserEntity(
        userId: 'u4',
        firstName: 'Bob',
        lastName: 'Marley',
        isLocationPermissionGranted: true,
        favoriteIds: [],
      );

      final copy = original.copyWith();

      expect(copy.userId, original.userId);
      expect(copy.firstName, original.firstName);
      expect(copy.lastName, original.lastName);
      expect(copy.isLocationPermissionGranted, original.isLocationPermissionGranted);
    });
  });
}
