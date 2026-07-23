import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';

void main() {
  group('OwnerModel', () {
    test('constructor assigns values correctly', () {
      final owner = OwnerEntity(
        id: '1',
        firstName: 'Alice',
        lastName: '',
        linkedItemIds: ['a', 'b'],
      );
      expect(owner.id, '1');
      expect(owner.firstName, 'Alice');
      expect(owner.linkedItemIds, ['a', 'b']);
    });

    test('fromJson creates correct OwnerModel', () {
      final json = {
        'id': '2',
        'first_name': 'Bob',
        'last_name': 'Chaise',
        'linked_ids': ['x', 'y'],
      };
      final owner = OwnerEntity.fromJson(json);
      expect(owner.id, '2');
      expect(owner.firstName, 'Bob');
      expect(owner.lastName, 'Chaise');
      expect(owner.linkedItemIds, ['x', 'y']);
    });

    test('equality and hashCode: identical objects', () {
      final o1 = OwnerEntity(id: '1', firstName: 'Alice', lastName: '', linkedItemIds: ['a', 'b']);
      final o2 = OwnerEntity(id: '1', firstName: 'Alice', lastName: '', linkedItemIds: ['a', 'b']);
      expect(o1, o2);
      expect(o1.hashCode, o2.hashCode);
    });

    test('equality and hashCode: different objects', () {
      final o1 = OwnerEntity(id: '1', firstName: 'Alice', lastName: '', linkedItemIds: ['a', 'b']);
      final o2 = OwnerEntity(id: '2', firstName: 'Alice', lastName: '', linkedItemIds: ['a', 'b']);
      final o3 = OwnerEntity(id: '1', firstName: 'Bob', lastName: '', linkedItemIds: ['a', 'b']);
      final o4 = OwnerEntity(id: '1', firstName: 'Alice', lastName: '', linkedItemIds: ['b', 'a']);
      expect(o1 == o2, isFalse);
      expect(o1 == o3, isFalse);
      expect(o1 == o4, isFalse); // order matters
      expect(o1.hashCode == o2.hashCode, isFalse);
      expect(o1.hashCode == o3.hashCode, isFalse);
      expect(o1.hashCode == o4.hashCode, isTrue);
    });
  });
}
