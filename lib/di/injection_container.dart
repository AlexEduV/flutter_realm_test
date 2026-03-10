import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:test_futter_project/data/data_sources/mock_article_service.dart';
import 'package:test_futter_project/data/data_sources/mock_auth_service.dart';
import 'package:test_futter_project/data/data_sources/mock_car_api_service.dart';
import 'package:test_futter_project/data/data_sources/mock_messages_service.dart';
import 'package:test_futter_project/data/data_sources/realm_local_storage.dart';
import 'package:test_futter_project/data/repositories/article_repository_impl.dart';
import 'package:test_futter_project/data/repositories/auth_repository_impl.dart';
import 'package:test_futter_project/data/repositories/permission_repository_impl.dart';
import 'package:test_futter_project/data/repositories/region_repository_impl.dart';
import 'package:test_futter_project/domain/data_sources/article_service.dart';
import 'package:test_futter_project/domain/data_sources/auth_service.dart';
import 'package:test_futter_project/domain/data_sources/base_local_storage.dart';
import 'package:test_futter_project/domain/data_sources/car_api_service.dart';
import 'package:test_futter_project/domain/data_sources/messages_service.dart';
import 'package:test_futter_project/domain/repositories/article_repository.dart';
import 'package:test_futter_project/domain/repositories/auth_repository.dart';
import 'package:test_futter_project/domain/repositories/permission_repository.dart';
import 'package:test_futter_project/domain/repositories/region_repository.dart';
import 'package:test_futter_project/domain/usecases/articles/fetch_articles_use_case.dart';
import 'package:test_futter_project/domain/usecases/articles/get_article_by_id_use_case.dart';
import 'package:test_futter_project/domain/usecases/authentication/delete_account_use_case.dart';
import 'package:test_futter_project/domain/usecases/authentication/login_use_case.dart';
import 'package:test_futter_project/domain/usecases/authentication/logout_use_case.dart';
import 'package:test_futter_project/domain/usecases/authentication/register_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/add_car_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/delete_all_cars_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/delete_car_by_id_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/get_all_cars_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/get_car_by_id_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/get_current_max_car_id_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/sync_cars_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/watch_cars_use_case.dart';
import 'package:test_futter_project/domain/usecases/inbox/fetch_messages_use_case.dart';
import 'package:test_futter_project/domain/usecases/permissions/check_location_permission_status_use_case.dart';
import 'package:test_futter_project/domain/usecases/permissions/request_location_permission_use_case.dart';
import 'package:test_futter_project/domain/usecases/regions/fetch_regions_use_case.dart';
import 'package:test_futter_project/domain/usecases/regions/get_all_regions_use_case.dart';
import 'package:test_futter_project/domain/usecases/regions/get_region_by_code_use_case.dart';
import 'package:test_futter_project/presentation/bloc/account/location_settings_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/article/article_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:test_futter_project/presentation/bloc/details/details_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
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
    [Car.schema, Person.schema, User.schema, LastSeenCar.schema],
    schemaVersion: 25,
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

  if (!serviceLocator.isRegistered<Realm>()) {
    serviceLocator.registerLazySingleton<Realm>(() => Realm(config));
  }

  serviceLocator.registerLazySingleton<BaseLocalStorage>(() => RealmLocalStorage(serviceLocator()));

  serviceLocator.registerLazySingleton<CarApiService>(() => MockCarApiService());

  serviceLocator.registerLazySingleton<AuthService>(() => MockAuthService(serviceLocator()));

  serviceLocator.registerLazySingleton<ArticleRepository>(() => ArticleRepositoryImpl());
  serviceLocator.registerLazySingleton<ArticleService>(() => MockArticleService(serviceLocator()));

  serviceLocator.registerLazySingleton<RegionRepository>(() => RegionRepositoryImpl());

  //Register Repository (passing Realm from GetIt)
  serviceLocator.registerLazySingleton<CarRepository>(
    () => CarRepositoryImpl(serviceLocator(), serviceLocator()),
  );

  serviceLocator.registerLazySingleton<PermissionRepository>(() => PermissionRepositoryImpl());

  final authRepositoryImpl = AuthRepositoryImpl(serviceLocator());
  await authRepositoryImpl.init();

  serviceLocator.registerLazySingleton<AuthRepository>(() => authRepositoryImpl);

  //Register Cubit (as a Factory, so you get a new instance if needed)
  serviceLocator.registerFactory(
    () => ExplorePageCubit(serviceLocator(), serviceLocator(), serviceLocator()),
  );

  serviceLocator.registerFactory(() => SearchPageCubit(serviceLocator(), serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => UserDataCubit(serviceLocator(), serviceLocator(), serviceLocator()),
  );

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

  serviceLocator.registerLazySingleton(() => AuthenticationCubit());

  serviceLocator.registerLazySingleton<MessagesService>(() => MockMessagesService());
  serviceLocator.registerLazySingleton(() => InboxPageCubit(serviceLocator()));

  serviceLocator.registerLazySingleton(() => LogoutUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => LoginUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => RegisterUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => DeleteAccountUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => FetchMessagesUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => FetchArticlesUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetArticleByIdUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => ArticlePageCubit(serviceLocator()));

  serviceLocator.registerLazySingleton(() => FetchRegionsUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetRegionByCodeUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetAllRegionsUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => AppLocalisationsCubit());
  serviceLocator.registerLazySingleton(() => LocationSettingsPageCubit());
}
