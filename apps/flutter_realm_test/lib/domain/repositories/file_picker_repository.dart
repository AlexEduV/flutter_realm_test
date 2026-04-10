import '../entities/attachment_entity.dart';

abstract class FilePickerRepository {
  Future<AttachmentEntity?> pickFile();
}
