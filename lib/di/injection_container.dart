import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';

import '../data/models/scheme.dart';
import '../data/repositories/car_repository_impl.dart';
import '../domain/repositories/car_repository.dart';
import '../presentation/bloc/home/home_page_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //Register Realm
  final config = Configuration.local(
    [Car.schema, Person.schema],
    schemaVersion: 2,
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

  serviceLocator.registerLazySingleton(() => Realm(config));

  //Register Repository (passing Realm from GetIt)
  serviceLocator.registerLazySingleton<CarRepository>(() => CarRepositoryImpl(serviceLocator()));

  //Register Cubit (as a Factory, so you get a new instance if needed)
  serviceLocator.registerFactory(() => HomePageCubit(serviceLocator()));
}
