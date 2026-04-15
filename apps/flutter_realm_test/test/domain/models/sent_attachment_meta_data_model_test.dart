import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/domain/models/sent_attachment_meta_data_model.dart';

void main() {
  group('SentAttachmentMetaDataModel', () {
    test('constructor and properties', () {
      final model = SentAttachmentMetaDataModel(
        name: 'file.txt',
        size: 1234,
        path: '/some/path/file.txt',
      );
      expect(model.name, 'file.txt');
      expect(model.size, 1234);
      expect(model.path, '/some/path/file.txt');
    });

    test('fromJson with all fields', () {
      final json = {'name': 'image.png', 'path': '/images/image.png', 'size': 2048};
      final model = SentAttachmentMetaDataModel.fromJson(json);
      expect(model.name, 'image.png');
      expect(model.path, '/images/image.png');
      expect(model.size, 2048);
    });

    test('fromJson with missing optional path', () {
      final json = {'name': 'doc.pdf', 'size': 512};
      final model = SentAttachmentMetaDataModel.fromJson(json);
      expect(model.name, 'doc.pdf');
      expect(model.path, isNull);
      expect(model.size, 512);
    });

    test('fromJson with missing name and size', () {
      final json = {'path': '/docs/doc.pdf'};
      final model = SentAttachmentMetaDataModel.fromJson(json);
      expect(model.name, '');
      expect(model.path, '/docs/doc.pdf');
      expect(model.size, 0);
    });
  });
}
