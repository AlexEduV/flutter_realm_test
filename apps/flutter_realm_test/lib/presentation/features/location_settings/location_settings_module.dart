import 'package:get_it/get_it.dart';
import 'package:test_flutter_project/domain/usecases/permissions/check_location_permission_status_use_case.dart';

import '../../../data/data_sources/remote/seed_region_remote_data_source_impl.dart';
import '../../../data/repositories/geolocator_repository_impl.dart';
import '../../../data/repositories/permission_repository_impl.dart';
import '../../../data/repositories/region_model_repository_impl.dart';
import '../../../data/repositories/region_repository_impl.dart';
import '../../../data/repositories/url_launch_repository_impl.dart';
import '../../../data/services/external_link_service_impl.dart';
import '../../../data/services/geolocator_service_impl.dart';
import '../../../data/services/permission_service_impl.dart';
import '../../../domain/data_sources/remote/region_remote_data_source.dart';
import '../../../domain/repositories/geolocator_repository.dart';
import '../../../domain/repositories/permission_repository.dart';
import '../../../domain/repositories/region_model_repository.dart';
import '../../../domain/repositories/region_repository.dart';
import '../../../domain/repositories/url_launch_repository.dart';
import '../../../domain/services/external_link_service.dart';
import '../../../domain/services/geolocator_service.dart';
import '../../../domain/services/permission_service.dart';
import '../../../domain/usecases/geolocator/check_location_service_status_use_case.dart';
import '../../../domain/usecases/geolocator/open_app_settings_use_case.dart';
import '../../../domain/usecases/permissions/request_location_permission_use_case.dart';
import '../../../domain/usecases/url/open_url_link_use_case.dart';
import 'location_settings_page_cubit.dart';

void registerLocationSettingsModule(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton<RegionRemoteDataSource>(
    () => SeedRegionRemoteDataSourceImpl(),
  );

  serviceLocator.registerLazySingleton<ExternalLinkService>(
    () => ExternalLinkServiceImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GeolocatorService>(() => GeolocatorServiceImpl());

  serviceLocator.registerLazySingleton<PermissionService>(() => PermissionServiceImpl());

  serviceLocator.registerLazySingleton<RegionRepository>(
    () => RegionRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<PermissionRepository>(
    () => PermissionRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<RegionModelRepository>(
    () => RegionModelRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GeolocatorRepository>(
    () => GeolocatorRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<UrlLaunchRepository>(
    () => UrlLaunchRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(() => OpenUrlLinkUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => OpenAppSettingsUseCase(serviceLocator(), serviceLocator()),
  );
  serviceLocator.registerLazySingleton(() => CheckLocationServiceStatusUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(
    () => CheckLocationPermissionStatusUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(() => RequestLocationPermissionUseCase(serviceLocator()));

  serviceLocator.registerFactory(
    () => LocationSettingsPageCubit(
      serviceLocator<RegionRepository>(),
      serviceLocator<RegionModelRepository>(),
      serviceLocator<OpenUrlLinkUseCase>(),
    ),
  );
}
