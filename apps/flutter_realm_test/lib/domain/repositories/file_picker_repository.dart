import '../entities/attachment_entity.dart';

abstract interface class FilePickerRepository {
  Future<AttachmentEntity?> pickFile();
}
