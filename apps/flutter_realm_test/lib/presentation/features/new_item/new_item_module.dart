import 'package:get_it/get_it.dart';
import 'package:test_flutter_project/domain/repositories/car_repository.dart';

import '../../../data/data_sources/remote/seed_auto_complete_remote_data_source_impl.dart';
import '../../../data/repositories/auto_complete_repository_impl.dart';
import '../../../domain/data_sources/remote/auto_complete_remote_data_source.dart';
import '../../../domain/repositories/auto_complete_repository.dart';
import '../../../domain/usecases/auto_complete/get_auto_complete_manufacturers_by_type_use_case.dart';
import '../../../domain/usecases/database/get_current_max_car_id_use_case.dart';
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
      serviceLocator<AppLocalisationsCubit>(),
      serviceLocator<UserDataCubit>(),
      serviceLocator<CarRepository>(),
      serviceLocator<GetAutoCompleteManufacturersByTypeUseCase>(),
      serviceLocator<GetCurrentMaxCarIdUseCase>(),
    ),
  );
}
