import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:test_futter_project/data/data_sources/local/geolocator_local_data_source_impl.dart';
import 'package:test_futter_project/data/data_sources/local/permission_local_data_source_impl.dart';
import 'package:test_futter_project/data/data_sources/local/realm_local_storage.dart';
import 'package:test_futter_project/data/data_sources/local/share_local_data_source_impl.dart';
import 'package:test_futter_project/data/data_sources/local/url_launch_local_data_source_impl.dart';
import 'package:test_futter_project/data/data_sources/remote/mock_article_remote_data_source_impl.dart';
import 'package:test_futter_project/data/data_sources/remote/mock_auth_remote_data_source_impl.dart';
import 'package:test_futter_project/data/data_sources/remote/mock_car_remote_data_source_impl.dart';
import 'package:test_futter_project/data/data_sources/remote/mock_messages_remote_data_source_impl.dart';
import 'package:test_futter_project/data/data_sources/remote/mock_owners_remote_data_source_impl.dart';
import 'package:test_futter_project/data/data_sources/remote/mock_region_remote_data_source_impl.dart';
import 'package:test_futter_project/data/repositories/article_repository_impl.dart';
import 'package:test_futter_project/data/repositories/auth_repository_impl.dart';
import 'package:test_futter_project/data/repositories/geolocator_repository_impl.dart';
import 'package:test_futter_project/data/repositories/inbox_repository_impl.dart';
import 'package:test_futter_project/data/repositories/owner_repository_impl.dart';
import 'package:test_futter_project/data/repositories/permission_repository_impl.dart';
import 'package:test_futter_project/data/repositories/region_repository_impl.dart';
import 'package:test_futter_project/data/repositories/share_repository_impl.dart';
import 'package:test_futter_project/data/repositories/url_launch_repository_impl.dart';
import 'package:test_futter_project/domain/data_sources/local/base_local_storage.dart';
import 'package:test_futter_project/domain/data_sources/local/geolocator_local_data_source.dart';
import 'package:test_futter_project/domain/data_sources/local/permission_local_data_source.dart';
import 'package:test_futter_project/domain/data_sources/local/share_local_data_source.dart';
import 'package:test_futter_project/domain/data_sources/local/url_launch_local_data_source.dart';
import 'package:test_futter_project/domain/data_sources/remote/article_remote_data_source.dart';
import 'package:test_futter_project/domain/data_sources/remote/auth_remote_data_source.dart';
import 'package:test_futter_project/domain/data_sources/remote/car_remote_data_source.dart';
import 'package:test_futter_project/domain/data_sources/remote/messages_remote_data_source.dart';
import 'package:test_futter_project/domain/data_sources/remote/owners_remote_data_source.dart';
import 'package:test_futter_project/domain/data_sources/remote/region_remote_data_source.dart';
import 'package:test_futter_project/domain/repositories/article_repository.dart';
import 'package:test_futter_project/domain/repositories/auth_repository.dart';
import 'package:test_futter_project/domain/repositories/inbox_repository.dart';
import 'package:test_futter_project/domain/repositories/owner_repository.dart';
import 'package:test_futter_project/domain/repositories/permission_repository.dart';
import 'package:test_futter_project/domain/repositories/region_repository.dart';
import 'package:test_futter_project/domain/repositories/share_repository.dart';
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
import 'package:test_futter_project/domain/usecases/geolocator/check_location_service_status_use_case.dart';
import 'package:test_futter_project/domain/usecases/geolocator/open_app_settings_use_case.dart';
import 'package:test_futter_project/domain/usecases/inbox/fetch_conversations_use_case.dart';
import 'package:test_futter_project/domain/usecases/inbox/get_conversation_by_id_use_case.dart';
import 'package:test_futter_project/domain/usecases/owners/fetch_owners_use_case.dart';
import 'package:test_futter_project/domain/usecases/owners/get_owner_by_id_use_case.dart';
import 'package:test_futter_project/domain/usecases/permissions/check_location_permission_status_use_case.dart';
import 'package:test_futter_project/domain/usecases/permissions/request_location_permission_use_case.dart';
import 'package:test_futter_project/domain/usecases/regions/fetch_regions_use_case.dart';
import 'package:test_futter_project/domain/usecases/regions/get_all_regions_use_case.dart';
import 'package:test_futter_project/domain/usecases/regions/get_region_by_code_use_case.dart';
import 'package:test_futter_project/domain/usecases/share/share_use_case.dart';
import 'package:test_futter_project/domain/usecases/url/open_url_link_use_case.dart';
import 'package:test_futter_project/domain/usecases/users/get_user_by_id_use_case.dart';
import 'package:test_futter_project/presentation/bloc/account/edit_dialog_cubit.dart';
import 'package:test_futter_project/presentation/bloc/article/article_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:test_futter_project/presentation/bloc/details/details_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_futter_project/presentation/bloc/messages/messages_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/share/share_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';

import '../data/models/scheme.dart';
import '../data/repositories/car_repository_impl.dart';
import '../domain/repositories/car_repository.dart';
import '../domain/repositories/geolocator_repository.dart';
import '../domain/repositories/url_launch_repository.dart';
import '../domain/usecases/inbox/save_conversations_use_case.dart';
import '../presentation/bloc/home/explore_page/explore_page_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependenciesContainer() async {
  //Register Realm
  final config = Configuration.local(
    [Car.schema, Person.schema, User.schema, LastSeenCar.schema],
    schemaVersion: 27,
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

      if (oldVersion < 27) {
        final oldUsers = migration.oldRealm.all('User');
        final newUsers = migration.newRealm.all<User>();

        for (var i = 0; i < oldUsers.length; i++) {
          final oldUser = oldUsers[i];
          final newUser = newUsers[i];

          // Move the old 'name' to 'firstName'
          final oldName = oldUser.dynamic.get<String>('name');
          final parts = oldName.split(' ');
          newUser.firstName = parts.isNotEmpty ? parts.first : '';
          newUser.lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';
        }
      }
    },
  );

  if (!serviceLocator.isRegistered<Realm>()) {
    serviceLocator.registerLazySingleton<Realm>(() => Realm(config));
  }

  serviceLocator.registerLazySingleton<BaseLocalStorage>(() => RealmLocalStorage(serviceLocator()));

  serviceLocator.registerLazySingleton<CarRemoteDataSource>(() => MockCarRemoteDataSourceImpl());
  serviceLocator.registerLazySingleton<OwnersRemoteDataSource>(() => MockOwnersRemoteDataSource());
  serviceLocator.registerLazySingleton<UrlLaunchLocalDataSource>(
    () => UrlLaunchLocalDataSourceImpl(),
  );
  serviceLocator.registerLazySingleton<RegionRemoteDataSource>(
    () => MockRegionRemoteDataSourceImpl(),
  );

  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => MockAuthRemoteDataSourceImpl(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<GeolocatorLocalDataSource>(
    () => GeolocatorLocalDataSourceImpl(),
  );
  serviceLocator.registerLazySingleton<ShareLocalDataSource>(() => ShareLocalDataSourceImpl());
  serviceLocator.registerLazySingleton<ShareRepository>(
    () => ShareRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<ArticleRepository>(
    () => ArticleRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<ArticleRemoteDataSource>(
    () => MockArticleRemoteDataSourceImpl(),
  );

  serviceLocator.registerLazySingleton<PermissionLocalDataSource>(() => AppPermissionService());

  serviceLocator.registerLazySingleton<RegionRepository>(() => RegionRepositoryImpl());

  serviceLocator.registerLazySingleton<OwnerRepository>(
    () => OwnerRepositoryImpl(serviceLocator()),
  );

  //Register Repository (passing Realm from GetIt)
  serviceLocator.registerLazySingleton<CarRepository>(
    () => CarRepositoryImpl(serviceLocator(), serviceLocator()),
  );

  serviceLocator.registerLazySingleton<PermissionRepository>(
    () => PermissionRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(() => FetchOwnersUseCase(serviceLocator()));

  final authRepositoryImpl = AuthRepositoryImpl(serviceLocator(), serviceLocator());
  await authRepositoryImpl.init();

  serviceLocator.registerLazySingleton<AuthRepository>(() => authRepositoryImpl);

  serviceLocator.registerFactory(
    () => ExplorePageCubit(serviceLocator(), serviceLocator(), serviceLocator()),
  );

  serviceLocator.registerFactory(() => SearchPageCubit(serviceLocator(), serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => UserDataCubit(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
    ),
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

  serviceLocator.registerLazySingleton<MessagesRemoteDataSource>(
    () => MockMessagesRemoteDataSourceImpl(),
  );
  serviceLocator.registerLazySingleton(() => InboxPageCubit(serviceLocator(), serviceLocator()));

  serviceLocator.registerLazySingleton(() => LogoutUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => LoginUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => RegisterUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => DeleteAccountUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => FetchConversationsUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => SaveConversationsUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => FetchArticlesUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetArticleByIdUseCase(serviceLocator()));
  serviceLocator.registerFactory(() => ArticlePageCubit(serviceLocator()));

  serviceLocator.registerLazySingleton(() => FetchRegionsUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetRegionByCodeUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetAllRegionsUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => OpenUrlLinkUseCase(serviceLocator()));

  //here
  serviceLocator.registerLazySingleton(() => GetOwnerByIdUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => AppLocalisationsCubit());

  serviceLocator.registerLazySingleton<GeolocatorRepository>(
    () => GeolocatorRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<UrlLaunchRepository>(
    () => UrlLaunchRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<OpenAppSettingsUseCase>(
    () => OpenAppSettingsUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<CheckLocationServiceStatusUseCase>(
    () => CheckLocationServiceStatusUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<ShareUseCase>(() => ShareUseCase(serviceLocator()));
  serviceLocator.registerFactory(() => ShareCubit(serviceLocator()));
  serviceLocator.registerFactory(() => EditDialogCubit());

  serviceLocator.registerLazySingleton<InboxRepository>(
    () => InboxRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(() => GetConversationByIdUseCase(serviceLocator()));

  serviceLocator.registerFactory(() => MessagesPageCubit());

  serviceLocator.registerLazySingleton(() => GetUserByIdUseCase());
}
