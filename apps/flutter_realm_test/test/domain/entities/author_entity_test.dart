import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/domain/entities/author_entity.dart';

void main() {
  group('AuthorEntity', () {
    test('constructor assigns values correctly', () {
      const author = AuthorEntity(id: '1', fullName: 'John Doe', imageSrc: 'img.png');
      expect(author.id, '1');
      expect(author.fullName, 'John Doe');
      expect(author.imageSrc, 'img.png');
    });

    test('fromJson creates correct AuthorEntity with imageSrc', () {
      final json = {'id': '2', 'full_name': 'Jane Smith', 'image_src': 'avatar.png'};
      final author = AuthorEntity.fromJson(json);
      expect(author.id, '2');
      expect(author.fullName, 'Jane Smith');
      expect(author.imageSrc, 'avatar.png');
    });

    test('fromJson creates correct AuthorEntity with null imageSrc', () {
      final json = {'id': '3', 'full_name': 'No Image', 'image_src': null};
      final author = AuthorEntity.fromJson(json);
      expect(author.id, '3');
      expect(author.fullName, 'No Image');
      expect(author.imageSrc, isNull);
    });

    test('equality and hashCode: identical objects', () {
      const a1 = AuthorEntity(id: '1', fullName: 'John Doe', imageSrc: 'img.png');
      const a2 = AuthorEntity(id: '1', fullName: 'John Doe', imageSrc: 'img.png');
      expect(a1, a2);
      expect(a1.hashCode, a2.hashCode);
    });

    test('equality and hashCode: different objects', () {
      const a1 = AuthorEntity(id: '1', fullName: 'John Doe', imageSrc: 'img.png');
      const a2 = AuthorEntity(id: '2', fullName: 'Jane Smith', imageSrc: 'avatar.png');
      expect(a1 == a2, isFalse);
      expect(a1.hashCode == a2.hashCode, isFalse);
    });

    test('equality and hashCode: null imageSrc', () {
      const a1 = AuthorEntity(id: '1', fullName: 'John Doe');
      const a2 = AuthorEntity(id: '1', fullName: 'John Doe', imageSrc: null);
      expect(a1, a2);
      expect(a1.hashCode, a2.hashCode);
    });
  });
}
