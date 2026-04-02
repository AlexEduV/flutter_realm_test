import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/data/dto/klipy_gif_dto.dart';
import 'package:test_futter_project/domain/entities/gif_entity.dart';

void main() {
  group('GifEntity', () {
    test('constructor sets all fields correctly', () {
      final entity = GifEntity(
        id: 'gif1',
        title: 'Funny Cat',
        previewImageUrl: 'http://preview.com/cat.gif',
        imageUrl: 'http://image.com/cat.gif',
        width: 320.0,
        height: 240.0,
      );

      expect(entity.id, 'gif1');
      expect(entity.title, 'Funny Cat');
      expect(entity.previewImageUrl, 'http://preview.com/cat.gif');
      expect(entity.imageUrl, 'http://image.com/cat.gif');
      expect(entity.width, 320.0);
      expect(entity.height, 240.0);
    });

    test('fromDto creates instance with correct values', () {
      final dto = KlipyGifDto(
        id: 'gif2',
        title: 'Dancing Dog',
        previewImageUrl: 'http://preview.com/dog.gif',
        imageUrl: 'http://image.com/dog.gif',
        width: 400.0,
        height: 300.0,
      );

      final entity = GifEntity.fromDto(dto);

      expect(entity.id, 'gif2');
      expect(entity.title, 'Dancing Dog');
      expect(entity.previewImageUrl, 'http://preview.com/dog.gif');
      expect(entity.imageUrl, 'http://image.com/dog.gif');
      expect(entity.width, 400.0);
      expect(entity.height, 300.0);
    });

    test('toPayload returns correct JSON string', () {
      final entity = GifEntity(
        id: 'gif3',
        title: 'Jumping Fox',
        previewImageUrl: 'http://preview.com/fox.gif',
        imageUrl: 'http://image.com/fox.gif',
        width: 500.0,
        height: 350.0,
      );

      final payload = entity.toPayload();
      final decoded = jsonDecode(payload);

      expect(decoded['url'], 'http://image.com/fox.gif');
      expect(decoded['width'], '500.0');
      expect(decoded['height'], '350.0');
    });

    group('hash code', () {
      final gif1 = GifEntity(
        id: '1',
        title: 'Funny Cat',
        previewImageUrl: 'http://example.com/preview1.gif',
        imageUrl: 'http://example.com/image1.gif',
        width: 320.0,
        height: 240.0,
      );

      final gif2 = GifEntity(
        id: '1',
        title: 'Funny Cat',
        previewImageUrl: 'http://example.com/preview1.gif',
        imageUrl: 'http://example.com/image1.gif',
        width: 320.0,
        height: 240.0,
      );

      final gif3 = GifEntity(
        id: '2',
        title: 'Funny Dog',
        previewImageUrl: 'http://example.com/preview2.gif',
        imageUrl: 'http://example.com/image2.gif',
        width: 640.0,
        height: 480.0,
      );

      test('should be equal if all properties are equal', () {
        expect(gif1, equals(gif2));
      });

      test('should not be equal if any property is different', () {
        expect(gif1, isNot(equals(gif3)));
      });

      test('should have the same hashCode for equal objects', () {
        expect(gif1.hashCode, equals(gif2.hashCode));
      });

      test('should have different hashCodes for different objects', () {
        expect(gif1.hashCode, isNot(equals(gif3.hashCode)));
      });
    });
  });
}
