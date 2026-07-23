import 'package:image_picker/image_picker.dart';
import 'package:test_flutter_project/domain/services/image_picker_service.dart';

class ImagePickerServiceImpl implements ImagePickerService {
  ImagePickerServiceImpl(this._imagePicker);

  final ImagePicker _imagePicker;

  @override
  Future<String?> pickImage() async {
    final result = await _imagePicker.pickImage(source: ImageSource.gallery);

    return result?.path;
  }
}
