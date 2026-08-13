import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:realm/realm.dart';
import 'package:test_flutter_project/common/extensions/get_it_extension.dart';
import 'package:test_flutter_project/core/network/app_http_client.dart';
import 'package:test_flutter_project/core/network/app_http_client_impl.dart';
import 'package:test_flutter_project/core/network/app_interceptor.dart';
import 'package:test_flutter_project/data/data_sources/local/env_local_data_source_impl.dart';
import 'package:test_flutter_project/data/data_sources/local/realm_local_storage.dart';
import 'package:test_flutter_project/data/database/realm_configuration.dart';
import 'package:test_flutter_project/data/repositories/env_repository_impl.dart';
import 'package:test_flutter_project/data/services/app_logging_service_impl.dart';
import 'package:test_flutter_project/data/services/network_logging_service_impl.dart';
import 'package:test_flutter_project/data/services/time_service_impl.dart';
import 'package:test_flutter_project/domain/data_sources/local/base_local_storage.dart';
import 'package:test_flutter_project/domain/data_sources/local/env_local_data_source.dart';
import 'package:test_flutter_project/domain/repositories/env_repository.dart';
import 'package:test_flutter_project/domain/services/logging_service.dart';
import 'package:test_flutter_project/domain/services/time_service.dart';
import 'package:test_flutter_project/domain/usecases/env/get_env_data_by_key_use_case.dart';
import 'package:test_flutter_project/domain/usecases/env/init_env_use_case.dart';
import 'package:test_flutter_project/presentation/features/account/account_module.dart';
import 'package:test_flutter_project/presentation/features/article/article_module.dart';
import 'package:test_flutter_project/presentation/features/authentication/authentication_module.dart';
import 'package:test_flutter_project/presentation/features/color_picker/color_picker_module.dart';
import 'package:test_flutter_project/presentation/features/details/details_module.dart';
import 'package:test_flutter_project/presentation/features/explore/explore_module.dart';
import 'package:test_flutter_project/presentation/features/home_bottom_bar/home_bottom_bar_module.dart';
import 'package:test_flutter_project/presentation/features/inbox/inbox_module.dart';
import 'package:test_flutter_project/presentation/features/l10n/l10n_module.dart';
import 'package:test_flutter_project/presentation/features/location_settings/location_settings_module.dart';
import 'package:test_flutter_project/presentation/features/messages/messages_module.dart';
import 'package:test_flutter_project/presentation/features/new_item/new_item_module.dart';
import 'package:test_flutter_project/presentation/features/search/search_module.dart';
import 'package:test_flutter_project/presentation/features/share/share_module.dart';
import 'package:test_flutter_project/presentation/features/user/user_module.dart';
import 'package:test_flutter_project/utils/date_formatter.dart';

final serviceLocator = GetIt.instance;

//todo: maybe convert to class;
///NOTE: explicit type annotations for registrations are used only in implementations of abstract classes
/// and when serviceLocator() is used as a param 3+ times.

Future<void> initDependenciesContainer() async {
  _registerStorage();
  _registerNetwork();
  await _registerEnv();
  _registerInfrastructure();

  registerMessagesModule(serviceLocator);
  registerUserModule(serviceLocator);
  registerLocationSettingsModule(serviceLocator);
  registerL10nModule(serviceLocator);
  await registerAuthenticationModule(serviceLocator);
  registerInboxModule(serviceLocator);
  registerHomeBottomBarModule(serviceLocator);
  registerExploreModule(serviceLocator);
  registerArticleModule(serviceLocator);
  registerDetailsModule(serviceLocator);
  registerColorPickerModule(serviceLocator);
  registerNewItemModule(serviceLocator);
  registerSearchModule(serviceLocator);
  registerShareModule(serviceLocator);
  registerAccountModule(serviceLocator);
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

void _registerInfrastructure() {
  serviceLocator.registerLazySingleton<TimeService>(() => TimeServiceImpl());
  serviceLocator.registerLazySingleton(() => DateFormatter(serviceLocator(), serviceLocator()));
}
