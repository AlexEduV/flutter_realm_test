import '../entities/attachment_entity.dart';

abstract class FilePickerService {
  Future<AttachmentEntity?> pickFile();
}
