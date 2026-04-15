import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';

void main() {
  group('OwnerEntity', () {
    test('constructor sets all fields correctly', () {
      final entity = OwnerEntity(
        id: 'owner1',
        firstName: 'John',
        lastName: 'Doe',
        linkedItemIds: ['id1', 'id2'],
        imageSrc: 'http://img.com/avatar.png',
      );

      expect(entity.id, 'owner1');
      expect(entity.firstName, 'John');
      expect(entity.lastName, 'Doe');
      expect(entity.linkedItemIds, ['id1', 'id2']);
      expect(entity.imageSrc, 'http://img.com/avatar.png');
    });

    test('fromJson creates instance with correct values', () {
      final json = {
        'id': 'owner2',
        'first_name': 'Jane',
        'last_name': 'Smith',
        'linked_ids': ['id3', 'id4'],
        'image_src': 'http://img.com/avatar2.png',
      };

      final entity = OwnerEntity.fromJson(json);

      expect(entity.id, 'owner2');
      expect(entity.firstName, 'Jane');
      expect(entity.lastName, 'Smith');
      expect(entity.linkedItemIds, ['id3', 'id4']);
      expect(entity.imageSrc, 'http://img.com/avatar2.png');
    });

    test('empty factory returns default values', () {
      final entity = OwnerEntity.empty();
      expect(entity.id, '');
      expect(entity.firstName, '');
      expect(entity.lastName, '');
      expect(entity.linkedItemIds, []);
      expect(entity.imageSrc, isNull);
    });

    test('fromUser creates instance from UserEntity', () {
      final user = const UserEntity(
        userId: 'user1',
        firstName: 'Alice',
        lastName: 'Wonder',
        createdIds: ['cid1', 'cid2'],
        avatarImageSrc: 'http://img.com/alice.png',
        isLocationPermissionGranted: true,
        favoriteIds: [],
        viewedIds: [],
        email: '',
        lastSeenCar: {},
        password: '',
        region: '',
      );

      final entity = OwnerEntity.fromUser(user);

      expect(entity.id, 'user1');
      expect(entity.firstName, 'Alice');
      expect(entity.lastName, 'Wonder');
      expect(entity.linkedItemIds, ['cid1', 'cid2']);
      expect(entity.imageSrc, 'http://img.com/alice.png');
    });

    test('== and hashCode for equal objects', () {
      final entity1 = OwnerEntity(
        id: 'owner1',
        firstName: 'John',
        lastName: 'Doe',
        linkedItemIds: ['id1', 'id2'],
        imageSrc: 'http://img.com/avatar.png',
      );
      final entity2 = OwnerEntity(
        id: 'owner1',
        firstName: 'John',
        lastName: 'Doe',
        linkedItemIds: ['id1', 'id2'],
        imageSrc: 'http://img.com/avatar.png',
      );
      expect(entity1, equals(entity2));
      expect(entity1.hashCode, equals(entity2.hashCode));
    });

    test('== and hashCode for different objects', () {
      final entity1 = OwnerEntity(
        id: 'owner1',
        firstName: 'John',
        lastName: 'Doe',
        linkedItemIds: ['id1', 'id2'],
        imageSrc: 'http://img.com/avatar.png',
      );
      final entity2 = OwnerEntity(
        id: 'owner2',
        firstName: 'Jane',
        lastName: 'Smith',
        linkedItemIds: ['id3'],
        imageSrc: 'http://img.com/avatar2.png',
      );
      expect(entity1 == entity2, isFalse);
      expect(entity1.hashCode == entity2.hashCode, isFalse);
    });
  });
}
