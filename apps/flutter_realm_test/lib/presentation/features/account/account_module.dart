import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/repositories/image_picker_repository_impl.dart';
import '../../../data/services/image_picker_service_impl.dart';
import '../../../domain/repositories/image_picker_repository.dart';
import '../../../domain/services/image_picker_service.dart';
import '../../../domain/usecases/image_picker/pick_image_from_gallery_use_case.dart';
import '../../widgets/dialogs/edit_dialog_cubit.dart';

void registerAccountModule(GetIt serviceLocator) {
  final imagePicker = ImagePicker();
  serviceLocator.registerLazySingleton<ImagePickerService>(
    () => ImagePickerServiceImpl(imagePicker),
  );

  serviceLocator.registerLazySingleton<ImagePickerRepository>(
    () => ImagePickerRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(() => PickImageFromGalleryUseCase(serviceLocator()));

  serviceLocator.registerFactory(() => EditDialogCubit());
}
