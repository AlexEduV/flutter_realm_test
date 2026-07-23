import 'package:test_flutter_project/domain/entities/attachment_entity.dart';
import 'package:test_flutter_project/domain/repositories/file_picker_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class PickAttachmentFileUseCase implements UseCaseNoParams<Future<AttachmentEntity?>> {
  PickAttachmentFileUseCase(this._filePickerRepository);

  final FilePickerRepository _filePickerRepository;

  @override
  Future<AttachmentEntity?> call() {
    return _filePickerRepository.pickFile();
  }
}
