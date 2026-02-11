import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:test_futter_project/data/data_sources/mock_car_api_service.dart';
import 'package:test_futter_project/data/data_sources/realm_local_storage.dart';
import 'package:test_futter_project/data/repositories/permission_repository_impl.dart';
import 'package:test_futter_project/domain/data_sources/car_api_service.dart';
import 'package:test_futter_project/domain/repositories/base_local_storage.dart';
import 'package:test_futter_project/domain/repositories/permission_repository.dart';
import 'package:test_futter_project/domain/usecases/database/add_car_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/delete_all_cars_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/delete_car_by_id_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/get_all_cars_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/get_car_by_id_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/get_current_max_car_id_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/sync_cars_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/watch_cars_use_case.dart';
import 'package:test_futter_project/domain/usecases/permissions/check_location_permission_status_use_case.dart';
import 'package:test_futter_project/domain/usecases/permissions/request_location_permission_use_case.dart';
import 'package:test_futter_project/presentation/bloc/details/details_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';

import '../data/models/scheme.dart';
import '../data/repositories/car_repository_impl.dart';
import '../domain/repositories/car_repository.dart';
import '../presentation/bloc/home/explore_page/explore_page_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependenciesContainer() async {
  //Register Realm
  final config = Configuration.local(
    [Car.schema, Person.schema, User.schema],
    schemaVersion: 12,
    migrationCallback: (migration, oldVersion) {
      //add object id
      if (oldVersion < 2) {
        final oldCars = migration.oldRealm.all('Car');

        for (final oldCar in oldCars) {
          final newCar = migration.findInNewRealm<Car>(oldCar);
          if (newCar != null) {
            newCar.id = ObjectId();
          }
        }
      }

      if (oldVersion < 10) {
        final oldUsers = migration.oldRealm.all('User');
        final newUsers = migration.newRealm.all<User>();

        // Loop through old data to ensure uniqueness before applying the PK
        for (var i = 0; i < oldUsers.length; i++) {
          final oldUser = oldUsers[i];
          final newUser = newUsers[i];

          // Ensure userId is unique and not null
          newUser.userId = oldUser.dynamic.get<String>('userId');
        }
      }
    },
  );

  serviceLocator.registerLazySingleton<Realm>(() => Realm(config));

  serviceLocator.registerLazySingleton<BaseLocalStorage>(() => RealmLocalStorage(serviceLocator()));

  serviceLocator.registerLazySingleton<CarApiService>(() => MockCarApiService());

  //Register Repository (passing Realm from GetIt)
  serviceLocator.registerLazySingleton<CarRepository>(
    () => CarRepositoryImpl(serviceLocator(), serviceLocator()),
  );

  serviceLocator.registerLazySingleton<PermissionRepository>(() => PermissionRepositoryImpl());

  //Register Cubit (as a Factory, so you get a new instance if needed)
  serviceLocator.registerFactory(() => ExplorePageCubit(serviceLocator(), serviceLocator()));

  serviceLocator.registerFactory(() => SearchPageCubit(serviceLocator(), serviceLocator()));

  serviceLocator.registerFactory(() => UserDataCubit(serviceLocator(), serviceLocator()));

  serviceLocator.registerFactory(() => HomeBottomBarCubit());

  serviceLocator.registerFactory(() => DetailsPageCubit(serviceLocator()));

  serviceLocator.registerLazySingleton(() => RequestLocationPermissionUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => CheckLocationPermissionStatusUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(() => WatchCarsUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => SyncCarsUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => AddCarUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => GetAllCarsUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => DeleteCarByIdUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => DeleteAllCarsUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => GetCarByIdUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => GetCurrentMaxCarIdUseCase(serviceLocator()));
}
