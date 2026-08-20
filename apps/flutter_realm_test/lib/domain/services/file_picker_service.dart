import '../entities/attachment_entity.dart';

abstract interface class FilePickerService {
  Future<AttachmentEntity?> pickFile();
}
