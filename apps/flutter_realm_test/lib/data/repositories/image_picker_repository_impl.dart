import 'package:test_flutter_project/domain/services/image_picker_service.dart';
import 'package:test_flutter_project/domain/repositories/image_picker_repository.dart';

class ImagePickerRepositoryImpl implements ImagePickerRepository {
  ImagePickerRepositoryImpl(this._imagePickerService);

  final ImagePickerService _imagePickerService;

  @override
  Future<String?> pickImage() {
    return _imagePickerService.pickImage();
  }
}
