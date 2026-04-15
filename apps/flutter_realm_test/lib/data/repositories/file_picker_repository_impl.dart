import 'package:test_flutter_project/domain/data_sources/local/file_picker_local_data_source.dart';
import 'package:test_flutter_project/domain/entities/attachment_entity.dart';

import '../../domain/repositories/file_picker_repository.dart';

class FilePickerRepositoryImpl implements FilePickerRepository {
  final FilePickerLocalDataSource _filePickerLocalDataSource;

  FilePickerRepositoryImpl(this._filePickerLocalDataSource);

  @override
  Future<AttachmentEntity?> pickFile() {
    return _filePickerLocalDataSource.pickFile();
  }
}
