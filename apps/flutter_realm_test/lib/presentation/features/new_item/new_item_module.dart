import 'package:get_it/get_it.dart';

import '../../../data/data_sources/remote/seed_auto_complete_remote_data_source_impl.dart';
import '../../../data/repositories/auto_complete_repository_impl.dart';
import '../../../domain/data_sources/remote/auto_complete_remote_data_source.dart';
import '../../../domain/repositories/auto_complete_repository.dart';
import '../../../domain/usecases/auto_complete/get_auto_complete_manufacturers_by_type_use_case.dart';
import '../../../domain/usecases/car_colors/get_car_color_by_name_use_case.dart';
import '../../../domain/usecases/car_colors/get_car_color_name_from_color_use_case.dart';
import '../../../domain/usecases/car_colors/get_car_colors_use_case.dart';
import '../../../domain/usecases/database/add_car_use_case.dart';
import '../../../domain/usecases/database/get_all_cars_use_case.dart';
import '../../../domain/usecases/database/get_current_max_car_id_use_case.dart';
import '../color_picker/color_picker_cubit.dart';
import '../l10n/app_localisations_cubit.dart';
import '../user/user_data_cubit.dart';
import 'new_item_page_cubit.dart';

void registerNewItemModule(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton<AutoCompleteRemoteDataSource>(
    () => SeedAutoCompleteRemoteDataSource(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<AutoCompleteRepository>(
    () => AutoCompleteRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => GetAutoCompleteManufacturersByTypeUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => NewItemPageCubit(
      serviceLocator<GetAutoCompleteManufacturersByTypeUseCase>(),
      serviceLocator<AppLocalisationsCubit>(),
      serviceLocator<AddCarUseCase>(),
      serviceLocator<GetAllCarsUseCase>(),
      serviceLocator<GetCurrentMaxCarIdUseCase>(),
      serviceLocator<UserDataCubit>(),
    ),
  );

  serviceLocator.registerFactory(
    () => ColorPickerCubit(
      serviceLocator<GetCarColorsUseCase>(),
      serviceLocator<GetCarColorByNameUseCase>(),
      serviceLocator<GetCarColorNameFromColorUseCase>(),
    ),
  );
}
