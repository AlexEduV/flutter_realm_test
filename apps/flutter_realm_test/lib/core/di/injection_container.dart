import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:realm/realm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_project/common/constants/api_constants.dart';
import 'package:test_flutter_project/common/extensions/get_it_extension.dart';
import 'package:test_flutter_project/core/network/app_http_client.dart';
import 'package:test_flutter_project/core/network/app_http_client_impl.dart';
import 'package:test_flutter_project/core/network/app_interceptor.dart';
import 'package:test_flutter_project/data/data_sources/local/car_color_local_data_source_impl.dart';
import 'package:test_flutter_project/data/data_sources/local/env_local_data_source_impl.dart';
import 'package:test_flutter_project/data/data_sources/local/realm_local_storage.dart';
import 'package:test_flutter_project/data/data_sources/remote/gifs_remote_data_source_impl.dart';
import 'package:test_flutter_project/data/data_sources/remote/mock_article_remote_data_source_impl.dart';
import 'package:test_flutter_project/data/data_sources/remote/mock_auto_complete_remote_data_source_impl.dart';
import 'package:test_flutter_project/data/data_sources/remote/mock_car_remote_data_source_impl.dart';
import 'package:test_flutter_project/data/data_sources/remote/mock_messages_remote_data_source_impl.dart';
import 'package:test_flutter_project/data/data_sources/remote/mock_owners_remote_data_source_impl.dart';
import 'package:test_flutter_project/data/data_sources/remote/mock_region_remote_data_source_impl.dart';
import 'package:test_flutter_project/data/data_sources/remote/mock_users_remote_data_source_impl.dart';
import 'package:test_flutter_project/data/database/realm_configuration.dart';
import 'package:test_flutter_project/data/repositories/article_repository_impl.dart';
import 'package:test_flutter_project/data/repositories/auth_repository_impl.dart';
import 'package:test_flutter_project/data/repositories/auto_complete_repository_impl.dart';
import 'package:test_flutter_project/data/repositories/car_color_repository_impl.dart';
import 'package:test_flutter_project/data/repositories/env_repository_impl.dart';
import 'package:test_flutter_project/data/repositories/file_picker_repository_impl.dart';
import 'package:test_flutter_project/data/repositories/geolocator_repository_impl.dart';
import 'package:test_flutter_project/data/repositories/gifs_repository_impl.dart';
import 'package:test_flutter_project/data/repositories/image_picker_repository_impl.dart';
import 'package:test_flutter_project/data/repositories/inbox_repository_impl.dart';
import 'package:test_flutter_project/data/repositories/owner_repository_impl.dart';
import 'package:test_flutter_project/data/repositories/permission_repository_impl.dart';
import 'package:test_flutter_project/data/repositories/region_model_repository_impl.dart';
import 'package:test_flutter_project/data/repositories/region_repository_impl.dart';
import 'package:test_flutter_project/data/repositories/share_repository_impl.dart';
import 'package:test_flutter_project/data/repositories/url_launch_repository_impl.dart';
import 'package:test_flutter_project/data/repositories/user_repository_impl.dart';
import 'package:test_flutter_project/data/services/app_logging_service_impl.dart';
import 'package:test_flutter_project/data/services/external_link_service_impl.dart';
import 'package:test_flutter_project/data/services/file_picker_service_impl.dart';
import 'package:test_flutter_project/data/services/geolocator_service_impl.dart';
import 'package:test_flutter_project/data/services/image_picker_service_impl.dart';
import 'package:test_flutter_project/data/services/network_logging_service_impl.dart';
import 'package:test_flutter_project/data/services/permission_service_impl.dart';
import 'package:test_flutter_project/data/services/share_service_impl.dart';
import 'package:test_flutter_project/domain/data_sources/local/base_local_storage.dart';
import 'package:test_flutter_project/domain/data_sources/local/car_colors_local_data_source.dart';
import 'package:test_flutter_project/domain/data_sources/local/env_local_data_source.dart';
import 'package:test_flutter_project/domain/data_sources/remote/article_remote_data_source.dart';
import 'package:test_flutter_project/domain/data_sources/remote/auto_complete_remote_data_source.dart';
import 'package:test_flutter_project/domain/data_sources/remote/car_remote_data_source.dart';
import 'package:test_flutter_project/domain/data_sources/remote/gifs_remote_data_source.dart';
import 'package:test_flutter_project/domain/data_sources/remote/messages_remote_data_source.dart';
import 'package:test_flutter_project/domain/data_sources/remote/owners_remote_data_source.dart';
import 'package:test_flutter_project/domain/data_sources/remote/region_remote_data_source.dart';
import 'package:test_flutter_project/domain/data_sources/remote/users_remote_data_source.dart';
import 'package:test_flutter_project/domain/models/env_params_model.dart';
import 'package:test_flutter_project/domain/repositories/article_repository.dart';
import 'package:test_flutter_project/domain/repositories/auth_repository.dart';
import 'package:test_flutter_project/domain/repositories/auto_complete_repository.dart';
import 'package:test_flutter_project/domain/repositories/car_color_repository.dart';
import 'package:test_flutter_project/domain/repositories/env_repository.dart';
import 'package:test_flutter_project/domain/repositories/file_picker_repository.dart';
import 'package:test_flutter_project/domain/repositories/gifs_repository.dart';
import 'package:test_flutter_project/domain/repositories/image_picker_repository.dart';
import 'package:test_flutter_project/domain/repositories/inbox_repository.dart';
import 'package:test_flutter_project/domain/repositories/owner_repository.dart';
import 'package:test_flutter_project/domain/repositories/permission_repository.dart';
import 'package:test_flutter_project/domain/repositories/region_model_repository.dart';
import 'package:test_flutter_project/domain/repositories/region_repository.dart';
import 'package:test_flutter_project/domain/repositories/share_repository.dart';
import 'package:test_flutter_project/domain/repositories/user_repository.dart';
import 'package:test_flutter_project/domain/services/external_link_service.dart';
import 'package:test_flutter_project/domain/services/file_picker_service.dart';
import 'package:test_flutter_project/domain/services/geolocator_service.dart';
import 'package:test_flutter_project/domain/services/image_picker_service.dart';
import 'package:test_flutter_project/domain/services/logging_service.dart';
import 'package:test_flutter_project/domain/services/permission_service.dart';
import 'package:test_flutter_project/domain/services/share_service.dart';
import 'package:test_flutter_project/domain/usecases/articles/fetch_articles_use_case.dart';
import 'package:test_flutter_project/domain/usecases/articles/get_article_by_id_use_case.dart';
import 'package:test_flutter_project/domain/usecases/authentication/delete_account_use_case.dart';
import 'package:test_flutter_project/domain/usecases/authentication/login_use_case.dart';
import 'package:test_flutter_project/domain/usecases/authentication/logout_use_case.dart';
import 'package:test_flutter_project/domain/usecases/authentication/register_use_case.dart';
import 'package:test_flutter_project/domain/usecases/auto_complete/get_auto_complete_manufacturers_by_type_use_case.dart';
import 'package:test_flutter_project/domain/usecases/car_colors/get_car_color_by_name_use_case.dart';
import 'package:test_flutter_project/domain/usecases/car_colors/get_car_color_name_from_color_use_case.dart';
import 'package:test_flutter_project/domain/usecases/car_colors/get_car_colors_use_case.dart';
import 'package:test_flutter_project/domain/usecases/database/add_car_use_case.dart';
import 'package:test_flutter_project/domain/usecases/database/delete_all_cars_use_case.dart';
import 'package:test_flutter_project/domain/usecases/database/delete_car_by_id_use_case.dart';
import 'package:test_flutter_project/domain/usecases/database/get_all_cars_use_case.dart';
import 'package:test_flutter_project/domain/usecases/database/get_car_by_id_use_case.dart';
import 'package:test_flutter_project/domain/usecases/database/get_current_max_car_id_use_case.dart';
import 'package:test_flutter_project/domain/usecases/database/sync_cars_use_case.dart';
import 'package:test_flutter_project/domain/usecases/database/watch_cars_use_case.dart';
import 'package:test_flutter_project/domain/usecases/env/get_env_data_by_key_use_case.dart';
import 'package:test_flutter_project/domain/usecases/env/init_env_use_case.dart';
import 'package:test_flutter_project/domain/usecases/file_picker/pick_attachment_file_use_case.dart';
import 'package:test_flutter_project/domain/usecases/geolocator/check_location_service_status_use_case.dart';
import 'package:test_flutter_project/domain/usecases/geolocator/open_app_settings_use_case.dart';
import 'package:test_flutter_project/domain/usecases/gifs/get_trending_gifs_use_case.dart';
import 'package:test_flutter_project/domain/usecases/gifs/search_gifs_use_case.dart';
import 'package:test_flutter_project/domain/usecases/image_picker/pick_image_from_gallery_use_case.dart';
import 'package:test_flutter_project/domain/usecases/inbox/extract_users_from_conversation_use_case.dart';
import 'package:test_flutter_project/domain/usecases/inbox/fetch_conversations_use_case.dart';
import 'package:test_flutter_project/domain/usecases/inbox/get_conversation_by_id_use_case.dart';
import 'package:test_flutter_project/domain/usecases/inbox/get_conversation_by_owner_id_use_case.dart';
import 'package:test_flutter_project/domain/usecases/owners/fetch_owners_use_case.dart';
import 'package:test_flutter_project/domain/usecases/owners/get_owner_by_id_use_case.dart';
import 'package:test_flutter_project/domain/usecases/permissions/check_location_permission_status_use_case.dart';
import 'package:test_flutter_project/domain/usecases/permissions/request_location_permission_use_case.dart';
import 'package:test_flutter_project/domain/usecases/regions/fetch_regions_use_case.dart';
import 'package:test_flutter_project/domain/usecases/regions/get_all_region_models_use_case.dart';
import 'package:test_flutter_project/domain/usecases/regions/get_all_regions_use_case.dart';
import 'package:test_flutter_project/domain/usecases/regions/get_region_by_code_use_case.dart';
import 'package:test_flutter_project/domain/usecases/regions/init_region_models_use_case.dart';
import 'package:test_flutter_project/domain/usecases/share/share_use_case.dart';
import 'package:test_flutter_project/domain/usecases/url/open_url_link_use_case.dart';
import 'package:test_flutter_project/domain/usecases/users/get_max_user_id_use_case.dart';
import 'package:test_flutter_project/domain/usecases/users/get_user_by_email_use_case.dart';
import 'package:test_flutter_project/domain/usecases/users/get_user_by_id_use_case.dart';
import 'package:test_flutter_project/domain/usecases/users/load_users_use_case.dart';
import 'package:test_flutter_project/domain/usecases/users/save_users_use_case.dart';
import 'package:test_flutter_project/features/location_settings_page/location_settings_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/account/edit_dialog_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/article/article_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/details/details_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/home/inbox_page/inbox_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/home/new_item_page/new_item_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/messages/messages_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/share/share_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_flutter_project/utils/date_formatter.dart';

import '../../data/repositories/car_repository_impl.dart';
import '../../domain/repositories/car_repository.dart';
import '../../domain/repositories/geolocator_repository.dart';
import '../../domain/repositories/url_launch_repository.dart';
import '../../domain/usecases/inbox/save_conversations_use_case.dart';
import '../../presentation/bloc/home/explore_page/explore_page_cubit.dart';

final serviceLocator = GetIt.instance;

//todo: maybe convert to class;
///NOTE: explicit type annotations for registrations are used only in implementations of abstract classes
/// and when serviceLocator() is used as a param 3+ times.

Future<void> initDependenciesContainer() async {
  _registerStorage();
  _registerNetwork();

  await _registerEnv();

  _registerServices();
  _registerDataSources();
  _registerUtils();

  await _registerRepositories();
  _registerUseCases();

  _registerCubits();
}

void _registerStorage() {
  if (serviceLocator.isNotRegistered<Realm>()) {
    try {
      final config = RealmConfiguration()..init();
      serviceLocator.registerLazySingleton<Realm>(() => Realm(config.instance));
    } catch (e) {
      debugPrint('Could not open realm');
    }
  }

  if (serviceLocator.isNotRegistered<BaseLocalStorage>()) {
    try {
      serviceLocator.registerLazySingleton<BaseLocalStorage>(
        () => RealmLocalStorage(serviceLocator()),
      );
    } catch (e) {
      debugPrint('Could not register local storage');
    }
  }
}

void _registerNetwork() {
  serviceLocator.registerLazySingleton<LoggingService>(() => AppLoggingServiceImpl());
  serviceLocator.registerLazySingleton<LoggingService>(
    () => NetworkLoggingServiceImpl(),
    instanceName: 'network',
  );

  final client = http.Client();
  final appInterceptor = AppInterceptor(serviceLocator<LoggingService>(instanceName: 'network'));
  serviceLocator.registerLazySingleton<AppHttpClient>(
    () => AppHttpClientImpl(client, appInterceptor),
  );
}

Future<void> _registerEnv() async {
  final dotEnv = dotenv;
  serviceLocator.registerLazySingleton<EnvLocalDataSource>(() => EnvLocalDataSourceImpl(dotEnv));
  serviceLocator.registerLazySingleton<EnvRepository>(() => EnvRepositoryImpl(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetEnvDataByKeyUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => InitEnvUseCase(serviceLocator()));
  try {
    await serviceLocator<InitEnvUseCase>().call();
  } catch (e) {
    debugPrint('Could not load .env file: $e');
  }
}

void _registerDataSources() {
  String apiKey = '';
  try {
    apiKey = serviceLocator<GetEnvDataByKeyUseCase>().call(
      EnvParamsModel(key: ApiConstants.envKlipyKeyPath),
    );
  } catch (e) {
    debugPrint('Could not load API key: $e');
  }
  serviceLocator.registerLazySingleton<GifsRemoteDataSource>(
    () => GifsRemoteDataSourceImpl(serviceLocator(), apiKey),
  );

  serviceLocator.registerLazySingleton<OwnersRemoteDataSource>(
    () => MockOwnersRemoteDataSourceImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<UsersRemoteDataSource>(
    () => MockUsersRemoteDataSourceImpl(),
  );

  final mockCarRemoteDataSource = MockCarRemoteDataSourceImpl(
    serviceLocator(),
    serviceLocator<OwnersRemoteDataSource>(),
  );
  mockCarRemoteDataSource.init();

  serviceLocator.registerLazySingleton<CarRemoteDataSource>(() => mockCarRemoteDataSource);

  serviceLocator.registerLazySingleton<AutoCompleteRemoteDataSource>(
    () => MockAutoCompleteRemoteDataSource(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<RegionRemoteDataSource>(
    () => MockRegionRemoteDataSourceImpl(),
  );

  serviceLocator.registerLazySingleton<CarColorLocalDataSource>(
    () => CarColorLocalDataSourceImpl(),
  );

  serviceLocator.registerLazySingleton<ArticleRemoteDataSource>(
    () => MockArticleRemoteDataSourceImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<MessagesRemoteDataSource>(
    () => MockMessagesRemoteDataSourceImpl(),
  );
}

void _registerServices() {
  final imagePicker = ImagePicker();
  serviceLocator.registerLazySingleton<ImagePickerService>(
    () => ImagePickerServiceImpl(imagePicker),
  );

  serviceLocator.registerLazySingleton<ExternalLinkService>(
    () => ExternalLinkServiceImpl(serviceLocator()),
  );

  final filePicker = FilePickerIO();
  serviceLocator.registerLazySingleton<FilePickerService>(() => FilePickerServiceImpl(filePicker));

  serviceLocator.registerLazySingleton<GeolocatorService>(() => GeolocatorServiceImpl());

  serviceLocator.registerLazySingleton<ShareService>(() => ShareServiceImpl());

  serviceLocator.registerLazySingleton<PermissionService>(() => PermissionServiceImpl());
}

void _registerUtils() {
  serviceLocator.registerLazySingleton(() => DateFormatter(serviceLocator()));
}

Future<void> _registerRepositories() async {
  serviceLocator.registerLazySingleton<OwnerRepository>(
    () => OwnerRepositoryImpl(serviceLocator(), serviceLocator()),
  );
  serviceLocator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(serviceLocator()));

  final cloudStorage = await SharedPreferences.getInstance();
  final authRepositoryImpl = AuthRepositoryImpl(
    serviceLocator<BaseLocalStorage>(),
    cloudStorage,
    serviceLocator<UsersRemoteDataSource>(),
    serviceLocator<MessagesRemoteDataSource>(),
    serviceLocator<OwnerRepository>(),
  );
  await authRepositoryImpl.init();

  serviceLocator.registerLazySingleton<CarRepository>(
    () => CarRepositoryImpl(serviceLocator(), serviceLocator()),
  );
  serviceLocator.registerLazySingleton<ShareRepository>(
    () => ShareRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<ArticleRepository>(
    () => ArticleRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<ImagePickerRepository>(
    () => ImagePickerRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<FilePickerRepository>(
    () => FilePickerRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<CarColorRepository>(
    () => CarColorRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<RegionRepository>(
    () => RegionRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<AutoCompleteRepository>(
    () => AutoCompleteRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<PermissionRepository>(
    () => PermissionRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<RegionModelRepository>(
    () => RegionModelRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<AuthRepository>(() => authRepositoryImpl);

  serviceLocator.registerLazySingleton<GeolocatorRepository>(
    () => GeolocatorRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<UrlLaunchRepository>(
    () => UrlLaunchRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<GifsRepository>(() => GifsRepositoryImpl(serviceLocator()));

  serviceLocator.registerLazySingleton<InboxRepository>(
    () => InboxRepositoryImpl(serviceLocator()),
  );
}

void _registerUseCases() {
  serviceLocator.registerLazySingleton(() => GetOwnerByIdUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => FetchOwnersUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => LoadUsersUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => SaveUsersUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetMaxUserIdUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetAllCarsUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetUserByIdUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetUserByEmailUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(
    () => CheckLocationPermissionStatusUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(() => WatchCarsUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => SyncCarsUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => AddCarUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => DeleteCarByIdUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => DeleteAllCarsUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetCarByIdUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetCurrentMaxCarIdUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => RequestLocationPermissionUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => LogoutUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => LoginUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => RegisterUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => DeleteAccountUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => FetchConversationsUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => SaveConversationsUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => FetchArticlesUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetArticleByIdUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => FetchRegionsUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetRegionByCodeUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetAllRegionsUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => OpenUrlLinkUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => OpenAppSettingsUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => CheckLocationServiceStatusUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => ShareUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => GetConversationByIdUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => GetConversationByOwnerIdUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => SearchGifsUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetTrendingGifsUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => PickImageFromGalleryUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => PickAttachmentFileUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => ExtractUsersFromConversationUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => GetAllRegionModelsUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => InitRegionModelsUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => GetCarColorsUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetCarColorByNameUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetCarColorNameFromColorUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => GetAutoCompleteManufacturersByTypeUseCase(serviceLocator()),
  );
}

void _registerCubits() {
  serviceLocator.registerFactory(
    () => ExplorePageCubit(
      serviceLocator<WatchCarsUseCase>(),
      serviceLocator<SyncCarsUseCase>(),
      serviceLocator<FetchArticlesUseCase>(),
      serviceLocator<GetCarByIdUseCase>(),
    ),
  );

  serviceLocator.registerFactory(
    () => NewItemPageCubit(
      serviceLocator<GetAutoCompleteManufacturersByTypeUseCase>(),
      serviceLocator<AppLocalisationsCubit>(),
      serviceLocator<AddCarUseCase>(),
      serviceLocator<GetAllCarsUseCase>(),
      serviceLocator<GetCurrentMaxCarIdUseCase>(),
      serviceLocator<UserDataCubit>(),
    ),
  );

  serviceLocator.registerFactory(
    () => SearchPageCubit(
      serviceLocator<GetAllCarsUseCase>(),
      serviceLocator<WatchCarsUseCase>(),
      serviceLocator<AppLocalisationsCubit>(),
    ),
  );

  serviceLocator.registerFactory(() => HomeBottomBarCubit());

  serviceLocator.registerFactory(
    () => DetailsPageCubit(
      serviceLocator<GetCarByIdUseCase>(),
      serviceLocator<GetCarColorsUseCase>(),
      serviceLocator<GetConversationByOwnerIdUseCase>(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AuthenticationCubit(
      serviceLocator<AppLocalisationsCubit>(),
      serviceLocator<UserDataCubit>(),
      serviceLocator<LoginUseCase>(),
      serviceLocator<LogoutUseCase>(),
      serviceLocator<RegisterUseCase>(),
      serviceLocator<DeleteAccountUseCase>(),
    ),
  );

  serviceLocator.registerLazySingleton(() => InboxPageCubit(serviceLocator(), serviceLocator()));

  serviceLocator.registerFactory(() => ArticlePageCubit(serviceLocator()));

  serviceLocator.registerFactory(
    () => LocationSettingsPageCubit(serviceLocator(), serviceLocator()),
  );

  serviceLocator.registerLazySingleton(() => AppLocalisationsCubit());

  serviceLocator.registerFactory(() => ShareCubit(serviceLocator()));
  serviceLocator.registerFactory(() => EditDialogCubit());

  serviceLocator.registerFactory(
    () => MessagesPageCubit(
      serviceLocator<SearchGifsUseCase>(),
      serviceLocator<GetTrendingGifsUseCase>(),
      serviceLocator<PickAttachmentFileUseCase>(),
      serviceLocator<GetConversationByIdUseCase>(),
      serviceLocator<GetOwnerByIdUseCase>(),
      serviceLocator<ExtractUsersFromConversationUseCase>(),
      serviceLocator<DateFormatter>(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => UserDataCubit(
      serviceLocator<BaseLocalStorage>(),
      serviceLocator<AuthRepository>(),
      serviceLocator<CheckLocationServiceStatusUseCase>(),
      serviceLocator<OpenAppSettingsUseCase>(),
      serviceLocator<RequestLocationPermissionUseCase>(),
      serviceLocator<CheckLocationPermissionStatusUseCase>(),
      serviceLocator<GetUserByEmailUseCase>(),
      serviceLocator<PickImageFromGalleryUseCase>(),
      serviceLocator<DeleteCarByIdUseCase>(),
      serviceLocator<LoggingService>(),
      serviceLocator<AppLocalisationsCubit>(),
    ),
  );
}
