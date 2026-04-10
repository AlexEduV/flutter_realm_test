import 'package:test_futter_project/domain/data_sources/local/image_picker_local_data_source.dart';
import 'package:test_futter_project/domain/repositories/image_picker_repository.dart';

class ImagePickerRepositoryImpl implements ImagePickerRepository {
  final ImagePickerLocalDataSource _imagePickerLocalDataSource;

  ImagePickerRepositoryImpl(this._imagePickerLocalDataSource);

  @override
  Future<String?> pickImage() {
    return _imagePickerLocalDataSource.pickImage();
  }
}
