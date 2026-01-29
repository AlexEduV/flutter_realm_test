import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:test_futter_project/data/data_sources/mock_car_api_service.dart';
import 'package:test_futter_project/data/data_sources/realm_local_storage.dart';
import 'package:test_futter_project/domain/data_sources/car_api_service.dart';
import 'package:test_futter_project/domain/repositories/base_local_storage.dart';

import '../data/models/scheme.dart';
import '../data/repositories/car_repository_impl.dart';
import '../domain/repositories/car_repository.dart';
import '../presentation/bloc/home/explore_page_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependenciesContainer() async {
  //Register Realm
  final config = Configuration.local(
    [Car.schema, Person.schema],
    schemaVersion: 4,
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
    },
  );

  serviceLocator.registerLazySingleton<Realm>(() => Realm(config));

  serviceLocator.registerLazySingleton<BaseLocalStorage>(() => RealmLocalStorage(serviceLocator()));

  serviceLocator.registerLazySingleton<CarApiService>(() => MockCarApiService());

  //Register Repository (passing Realm from GetIt)
  serviceLocator.registerLazySingleton<CarRepository>(
    () => CarRepositoryImpl(serviceLocator(), serviceLocator()),
  );

  //Register Cubit (as a Factory, so you get a new instance if needed)
  serviceLocator.registerFactory(() => ExplorePageCubit(serviceLocator()));
}
