import '../../entities/attachment_entity.dart';

abstract class FilePickerLocalDataSource {
  Future<AttachmentEntity?> pickFile();
}
