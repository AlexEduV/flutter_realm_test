import 'package:get_it/get_it.dart';

import '../../../data/data_sources/remote/seed_car_remote_data_source_impl.dart';
import '../../../data/repositories/car_repository_impl.dart';
import '../../../domain/data_sources/remote/car_remote_data_source.dart';
import '../../../domain/data_sources/remote/owners_remote_data_source.dart';
import '../../../domain/repositories/car_repository.dart';
import '../../../domain/usecases/articles/fetch_articles_use_case.dart';
import '../../../domain/usecases/database/add_car_use_case.dart';
import '../../../domain/usecases/database/delete_all_cars_use_case.dart';
import '../../../domain/usecases/database/delete_car_by_id_use_case.dart';
import '../../../domain/usecases/database/get_all_cars_use_case.dart';
import '../../../domain/usecases/database/get_car_by_id_use_case.dart';
import '../../../domain/usecases/database/get_current_max_car_id_use_case.dart';
import '../../../domain/usecases/database/sync_cars_use_case.dart';
import '../../../domain/usecases/database/watch_cars_use_case.dart';
import 'explore_page_cubit.dart';

void registerExploreModule(GetIt serviceLocator) {
  final mockCarRemoteDataSource = SeedCarRemoteDataSourceImpl(
    serviceLocator(),
    serviceLocator<OwnersRemoteDataSource>(),
  );
  mockCarRemoteDataSource.init();

  serviceLocator.registerLazySingleton<CarRemoteDataSource>(() => mockCarRemoteDataSource);

  serviceLocator.registerLazySingleton<CarRepository>(
    () => CarRepositoryImpl(serviceLocator(), serviceLocator()),
  );

  serviceLocator.registerLazySingleton(() => GetAllCarsUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => WatchCarsUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => SyncCarsUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => AddCarUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => DeleteCarByIdUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => DeleteAllCarsUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetCarByIdUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetCurrentMaxCarIdUseCase(serviceLocator()));

  serviceLocator.registerFactory(
    () => ExplorePageCubit(
      serviceLocator<WatchCarsUseCase>(),
      serviceLocator<SyncCarsUseCase>(),
      serviceLocator<FetchArticlesUseCase>(),
      serviceLocator<GetCarByIdUseCase>(),
    ),
  );
}
