import 'package:get_it/get_it.dart';
import 'package:test_flutter_project/domain/repositories/car_repository.dart';
import 'package:test_flutter_project/domain/repositories/image_picker_repository.dart';
import 'package:test_flutter_project/domain/services/time_service.dart';

import '../../../data/data_sources/remote/seed_owners_remote_data_source_impl.dart';
import '../../../data/data_sources/remote/seed_users_remote_data_source_impl.dart';
import '../../../data/repositories/owner_repository_impl.dart';
import '../../../data/repositories/user_repository_impl.dart';
import '../../../domain/data_sources/remote/owners_remote_data_source.dart';
import '../../../domain/data_sources/remote/users_remote_data_source.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/owner_repository.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../../domain/usecases/geolocator/check_location_service_status_use_case.dart';
import '../../../domain/usecases/geolocator/open_app_settings_use_case.dart';
import '../../../domain/usecases/permissions/check_location_permission_status_use_case.dart';
import '../../../domain/usecases/permissions/request_location_permission_use_case.dart';
import '../l10n/app_localisations_cubit.dart';
import 'user_data_cubit.dart';

void registerUserModule(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton<OwnersRemoteDataSource>(
    () => SeedOwnersRemoteDataSourceImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<UsersRemoteDataSource>(
    () => SeedUsersRemoteDataSourceImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<OwnerRepository>(
    () => OwnerRepositoryImpl(serviceLocator(), serviceLocator()),
  );
  serviceLocator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(serviceLocator(), serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => UserDataCubit(
      serviceLocator<TimeService>(),
      serviceLocator<UserRepository>(),
      serviceLocator<AuthRepository>(),
      serviceLocator<ImagePickerRepository>(),
      serviceLocator<CarRepository>(),
      serviceLocator<CheckLocationServiceStatusUseCase>(),
      serviceLocator<OpenAppSettingsUseCase>(),
      serviceLocator<RequestLocationPermissionUseCase>(),
      serviceLocator<CheckLocationPermissionStatusUseCase>(),
      serviceLocator<AppLocalisationsCubit>(),
    ),
  );
}
