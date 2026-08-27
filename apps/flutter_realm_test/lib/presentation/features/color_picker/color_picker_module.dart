import 'package:get_it/get_it.dart';
import 'package:test_flutter_project/domain/repositories/car_color_repository.dart';

import 'color_picker_cubit.dart';

void registerColorPickerModule(GetIt serviceLocator) {
  serviceLocator.registerFactory(() => ColorPickerCubit(serviceLocator<CarColorRepository>()));
}
