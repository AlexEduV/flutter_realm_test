import 'package:image_picker/image_picker.dart';
import 'package:test_flutter_project/domain/data_sources/local/image_picker_local_data_source.dart';

class ImagePickerLocalDataSourceImpl implements ImagePickerLocalDataSource {
  final ImagePicker _imagePicker;

  ImagePickerLocalDataSourceImpl(this._imagePicker);

  @override
  Future<String?> pickImage() async {
    final result = await _imagePicker.pickImage(source: ImageSource.gallery);

    return result?.path;
  }
}
