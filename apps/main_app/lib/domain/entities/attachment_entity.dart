import 'dart:convert';

import 'package:file_picker/file_picker.dart';

class AttachmentEntity {
  final String name;
  final String? path;
  final int size;

  AttachmentEntity({required this.name, required this.size, this.path});

  factory AttachmentEntity.fromPlatformFile(PlatformFile file) {
    return AttachmentEntity(name: file.name, path: file.path, size: file.size);
  }

  String toPayload() {
    return jsonEncode({'file': true, 'name': name, if (path != null) 'path': path, 'size': size});
  }
}
