import 'package:image_picker/image_picker.dart';
import 'package:test_futter_project/domain/data_sources/local/image_picker_local_data_source.dart';

class ImagePickerLocalDataSourceImpl implements ImagePickerLocalDataSource {
  final ImagePicker imagePicker = ImagePicker();

  @override
  Future<String?> pickImage() async {
    final result = await imagePicker.pickImage(source: ImageSource.gallery);

    return result?.path;
  }
}
