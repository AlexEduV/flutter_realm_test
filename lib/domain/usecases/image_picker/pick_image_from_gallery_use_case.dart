import 'package:test_futter_project/domain/repositories/image_picker_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class PickImageFromGalleryUseCase implements UseCaseNoParams<Future<String?>> {
  PickImageFromGalleryUseCase(this._imagePickerRepository);

  final ImagePickerRepository _imagePickerRepository;

  @override
  Future<String?> call() {
    return _imagePickerRepository.pickImage();
  }
}
