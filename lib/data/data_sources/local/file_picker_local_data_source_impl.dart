import 'package:file_picker/file_picker.dart';
import 'package:test_futter_project/domain/entities/attachment_entity.dart';

import '../../../domain/data_sources/local/file_picker_local_data_source.dart';

class FilePickerLocalDataSourceImpl implements FilePickerLocalDataSource {
  final filePicker = FilePickerIO();

  @override
  Future<AttachmentEntity?> pickFile() async {
    final result = await filePicker.pickFiles(type: FileType.media);
    final file = result?.files.firstOrNull;
    if (file == null) return null;

    return AttachmentEntity.fromPlatformFile(file);
  }
}
