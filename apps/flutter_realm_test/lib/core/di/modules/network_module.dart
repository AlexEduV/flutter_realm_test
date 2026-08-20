import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../../data/network/app_http_client.dart';
import '../../../data/network/app_http_client_impl.dart';
import '../../../data/network/app_interceptor.dart';
import '../../../data/services/app_logging_service_impl.dart';
import '../../../data/services/network_logging_service_impl.dart';
import '../../../domain/services/logging_service.dart';

void registerNetworkModule(GetIt serviceLocator) {
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
