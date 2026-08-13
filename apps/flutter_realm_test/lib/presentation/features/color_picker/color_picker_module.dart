import 'package:get_it/get_it.dart';

import '../../../domain/usecases/car_colors/get_car_color_by_name_use_case.dart';
import '../../../domain/usecases/car_colors/get_car_color_name_from_color_use_case.dart';
import '../../../domain/usecases/car_colors/get_car_colors_use_case.dart';
import 'color_picker_cubit.dart';

void registerColorPickerModule(GetIt serviceLocator) {
  serviceLocator.registerFactory(
    () => ColorPickerCubit(
      serviceLocator<GetCarColorsUseCase>(),
      serviceLocator<GetCarColorByNameUseCase>(),
      serviceLocator<GetCarColorNameFromColorUseCase>(),
    ),
  );
}
