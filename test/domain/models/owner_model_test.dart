import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/domain/models/owner_model.dart';

void main() {
  group('OwnerModel', () {
    test('constructor assigns values correctly', () {
      final owner = OwnerModel(id: '1', name: 'Alice', linkedItemIds: ['a', 'b']);
      expect(owner.id, '1');
      expect(owner.name, 'Alice');
      expect(owner.linkedItemIds, ['a', 'b']);
    });

    test('fromJson creates correct OwnerModel', () {
      final json = {
        'id': '2',
        'full_name': 'Bob',
        'linked_ids': ['x', 'y'],
      };
      final owner = OwnerModel.fromJson(json);
      expect(owner.id, '2');
      expect(owner.name, 'Bob');
      expect(owner.linkedItemIds, ['x', 'y']);
    });

    test('equality and hashCode: identical objects', () {
      final o1 = OwnerModel(id: '1', name: 'Alice', linkedItemIds: ['a', 'b']);
      final o2 = OwnerModel(id: '1', name: 'Alice', linkedItemIds: ['a', 'b']);
      expect(o1, o2);
      expect(o1.hashCode, o2.hashCode);
    });

    test('equality and hashCode: different objects', () {
      final o1 = OwnerModel(id: '1', name: 'Alice', linkedItemIds: ['a', 'b']);
      final o2 = OwnerModel(id: '2', name: 'Alice', linkedItemIds: ['a', 'b']);
      final o3 = OwnerModel(id: '1', name: 'Bob', linkedItemIds: ['a', 'b']);
      final o4 = OwnerModel(id: '1', name: 'Alice', linkedItemIds: ['b', 'a']);
      expect(o1 == o2, isFalse);
      expect(o1 == o3, isFalse);
      expect(o1 == o4, isFalse); // order matters
      expect(o1.hashCode == o2.hashCode, isFalse);
      expect(o1.hashCode == o3.hashCode, isFalse);
      expect(o1.hashCode == o4.hashCode, isTrue);
    });
  });
}
