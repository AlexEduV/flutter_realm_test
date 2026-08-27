import 'package:get_it/get_it.dart';

import '../../../data/data_sources/remote/seed_car_remote_data_source_impl.dart';
import '../../../data/repositories/car_repository_impl.dart';
import '../../../domain/data_sources/remote/car_remote_data_source.dart';
import '../../../domain/data_sources/remote/owners_remote_data_source.dart';
import '../../../domain/repositories/car_repository.dart';
import '../../../domain/usecases/articles/fetch_articles_use_case.dart';
import '../../../domain/usecases/database/get_car_by_id_use_case.dart';
import '../../../domain/usecases/database/get_current_max_car_id_use_case.dart';
import 'explore_page_cubit.dart';

void registerExploreModule(GetIt serviceLocator) {
  final seedCarRemoteDataSource = SeedCarRemoteDataSourceImpl(
    serviceLocator(),
    serviceLocator<OwnersRemoteDataSource>(),
  );
  seedCarRemoteDataSource.init();

  serviceLocator.registerLazySingleton<CarRemoteDataSource>(
    () => seedCarRemoteDataSource,
    dispose: (dataSource) => dataSource.dispose(),
  );

  serviceLocator.registerLazySingleton<CarRepository>(
    () => CarRepositoryImpl(serviceLocator(), serviceLocator(), serviceLocator()),
    dispose: (repo) => (repo as CarRepositoryImpl).close(),
  );

  serviceLocator.registerLazySingleton(() => GetCarByIdUseCase(serviceLocator(), serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetCurrentMaxCarIdUseCase(serviceLocator()));

  serviceLocator.registerFactory(
    () => ExplorePageCubit(
      serviceLocator<CarRepository>(),
      serviceLocator<FetchArticlesUseCase>(),
      serviceLocator<GetCarByIdUseCase>(),
    ),
  );
}
