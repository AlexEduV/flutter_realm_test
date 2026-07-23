import 'package:test_flutter_project/domain/services/file_picker_service.dart';
import 'package:test_flutter_project/domain/entities/attachment_entity.dart';

import '../../domain/repositories/file_picker_repository.dart';

class FilePickerRepositoryImpl implements FilePickerRepository {
  FilePickerRepositoryImpl(this._filePickerService);

  final FilePickerService _filePickerService;

  @override
  Future<AttachmentEntity?> pickFile() {
    return _filePickerService.pickFile();
  }
}
