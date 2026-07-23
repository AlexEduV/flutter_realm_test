import 'package:file_picker/file_picker.dart';
import 'package:test_flutter_project/domain/entities/attachment_entity.dart';

import '../../domain/services/file_picker_service.dart';

class FilePickerServiceImpl implements FilePickerService {
  FilePickerServiceImpl(this.filePicker);

  final FilePickerIO filePicker;

  @override
  Future<AttachmentEntity?> pickFile() async {
    final result = await filePicker.pickFiles(type: FileType.media);
    final file = result?.files.firstOrNull;
    if (file == null) return null;

    return AttachmentEntity.fromPlatformFile(file);
  }
}
