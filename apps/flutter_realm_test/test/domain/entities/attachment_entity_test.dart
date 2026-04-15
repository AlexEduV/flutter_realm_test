import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/entities/attachment_entity.dart';

import 'attachment_entity_test.mocks.dart';

@GenerateMocks([PlatformFile])
void main() {
  group('AttachmentEntity', () {
    test('constructor and properties', () {
      final entity = AttachmentEntity(name: 'file.txt', size: 123, path: '/some/path/file.txt');
      expect(entity.name, 'file.txt');
      expect(entity.size, 123);
      expect(entity.path, '/some/path/file.txt');
    });

    test('fromPlatformFile creates entity from PlatformFile', () {
      final mockFile = MockPlatformFile();
      when(mockFile.name).thenReturn('image.png');
      when(mockFile.path).thenReturn('/images/image.png');
      when(mockFile.size).thenReturn(2048);

      final entity = AttachmentEntity.fromPlatformFile(mockFile);

      expect(entity.name, 'image.png');
      expect(entity.path, '/images/image.png');
      expect(entity.size, 2048);
    });

    test('toPayload includes path when present', () {
      final entity = AttachmentEntity(name: 'file.txt', size: 123, path: '/some/path/file.txt');
      final payload = entity.toPayload();
      final decoded = jsonDecode(payload);
      expect(decoded['file'], true);
      expect(decoded['name'], 'file.txt');
      expect(decoded['path'], '/some/path/file.txt');
      expect(decoded['size'], 123);
    });

    test('toPayload omits path when null', () {
      final entity = AttachmentEntity(name: 'file.txt', size: 123, path: null);
      final payload = entity.toPayload();
      final decoded = jsonDecode(payload);
      expect(decoded['file'], true);
      expect(decoded['name'], 'file.txt');
      expect(decoded.containsKey('path'), false);
      expect(decoded['size'], 123);
    });
  });
}
