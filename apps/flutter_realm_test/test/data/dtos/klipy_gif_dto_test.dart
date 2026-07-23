import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/data/dto/klipy_gif_dto.dart';

void main() {
  group('KlipyGifDto', () {
    test('constructor sets all fields correctly', () {
      final dto = KlipyGifDto(
        id: 'gif1',
        title: 'Funny Cat',
        previewImageUrl: 'http://preview.com/cat.gif',
        imageUrl: 'http://image.com/cat.gif',
        width: 320.0,
        height: 240.0,
      );

      expect(dto.id, 'gif1');
      expect(dto.title, 'Funny Cat');
      expect(dto.previewImageUrl, 'http://preview.com/cat.gif');
      expect(dto.imageUrl, 'http://image.com/cat.gif');
      expect(dto.width, 320.0);
      expect(dto.height, 240.0);
    });

    test('fromJson parses v2 format correctly', () {
      final json = {
        'id': 'gif2',
        'title': 'Dancing Dog',
        'media_formats': {
          'gif': {'url': 'http://image.com/dog.gif'},
          'tinygif': {
            'url': 'http://preview.com/dog.gif',
            'dims': [400, 300],
          },
        },
      };

      final dto = KlipyGifDto.fromJson(json);

      expect(dto.id, 'gif2');
      expect(dto.title, 'Dancing Dog');
      expect(dto.imageUrl, 'http://image.com/dog.gif');
      expect(dto.previewImageUrl, 'http://preview.com/dog.gif');
      expect(dto.width, 400.0);
      expect(dto.height, 300.0);
    });

    test('fromV1Json parses v1 format correctly', () {
      final json = {
        'id': 123,
        'title': 'Jumping Fox',
        'file': {
          'sm': {
            'gif': {'url': 'http://image.com/fox.gif', 'width': 500, 'height': 350},
          },
          'xs': {
            'gif': {'url': 'http://preview.com/fox.gif'},
          },
        },
      };

      final dto = KlipyGifDto.fromV1Json(json);

      expect(dto.id, '123');
      expect(dto.title, 'Jumping Fox');
      expect(dto.imageUrl, 'http://image.com/fox.gif');
      expect(dto.previewImageUrl, 'http://preview.com/fox.gif');
      expect(dto.width, 500.0);
      expect(dto.height, 350.0);
    });
  });
}
