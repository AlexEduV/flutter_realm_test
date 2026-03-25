import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/domain/models/sent_image_meta_data_model.dart';

void main() {
  group('SentImageMetaDataModel', () {
    test('constructor and properties', () {
      final model = SentImageMetaDataModel(
        url: 'https://example.com/image.png',
        width: 200.0,
        height: 100.0,
      );
      expect(model.url, 'https://example.com/image.png');
      expect(model.width, 200.0);
      expect(model.height, 100.0);
    });

    test('fromJson with all fields', () {
      final json = {'url': 'https://example.com/image.png', 'width': '300.5', 'height': '150.25'};
      final model = SentImageMetaDataModel.fromJson(json);
      expect(model.url, 'https://example.com/image.png');
      expect(model.width, 300.5);
      expect(model.height, 150.25);
    });

    test('fromJson with missing url', () {
      final json = {'width': '50', 'height': '25'};
      final model = SentImageMetaDataModel.fromJson(json);
      expect(model.url, '');
      expect(model.width, 50.0);
      expect(model.height, 25.0);
    });

    test('fromJson with invalid width/height', () {
      final json = {
        'url': 'https://example.com/image.png',
        'width': 'not_a_number',
        'height': 'also_not_a_number',
      };
      final model = SentImageMetaDataModel.fromJson(json);
      expect(model.url, 'https://example.com/image.png');
      expect(model.width, 0.0);
      expect(model.height, 0.0);
    });

    test('getImageFactor returns correct ratio', () {
      final model = SentImageMetaDataModel(url: 'url', width: 100.0, height: 50.0);
      expect(model.getImageFactor(), 0.5);
    });

    test('getImageFactor returns 1.0 when width is 0', () {
      final model = SentImageMetaDataModel(url: 'url', width: 0.0, height: 50.0);
      expect(model.getImageFactor(), 1.0);
    });
  });
}
