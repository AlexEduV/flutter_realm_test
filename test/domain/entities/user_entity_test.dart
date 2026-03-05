import 'package:flutter_test/flutter_test.dart';
import 'package:realm/realm.dart';
import 'package:test_futter_project/data/models/scheme.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';

void main() {
  group('UserEntity', () {
    test('constructor sets all fields correctly', () {
      const entity = UserEntity(
        userId: 'u1',
        firstName: 'John',
        lastName: 'Doe',
        isLocationPermissionGranted: true,
        favoriteIds: [],
        email: 'mock@gmail.com',
        password: '',
        lastSeenCar: null,
        region: 'uk',
        createdIds: [],
        avatarImageSrc: null,
        viewedIds: [],
      );

      expect(entity.userId, 'u1');
      expect(entity.firstName, 'John');
      expect(entity.lastName, 'Doe');
      expect(entity.isLocationPermissionGranted, true);
      expect(entity.email, 'mock@gmail.com');
    });

    test('fromSchema creates UserEntity from User', () {
      final mockUser = User(
        'u2',
        'Jane',
        'Smith',
        'mock@gmail.com',
        '',
        false,
        'uk',
        favoriteIds: RealmList([]),
      );

      final entity = UserEntity.fromSchema(mockUser);

      expect(entity.userId, 'u2');
      expect(entity.firstName, 'Jane');
      expect(entity.lastName, 'Smith');
      expect(entity.isLocationPermissionGranted, false);
      expect(entity.favoriteIds, []);
      expect(entity.email, 'mock@gmail.com');
    });

    test('copyWith returns a new UserEntity with updated fields', () {
      const original = UserEntity(
        userId: 'u3',
        firstName: 'Alice',
        lastName: 'Brown',
        isLocationPermissionGranted: false,
        favoriteIds: [],
        email: 'mock@gmail.com',
        password: '',
        lastSeenCar: null,
        region: 'uk',
        createdIds: [],
        avatarImageSrc: null,
        viewedIds: [],
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
        password: '',
        email: 'mock@gmail.com',
        lastSeenCar: null,
        region: 'uk',
        createdIds: [],
        avatarImageSrc: null,
        viewedIds: [],
      );

      final copy = original.copyWith();

      expect(copy.userId, original.userId);
      expect(copy.firstName, original.firstName);
      expect(copy.lastName, original.lastName);
      expect(copy.isLocationPermissionGranted, original.isLocationPermissionGranted);
    });
  });
}
