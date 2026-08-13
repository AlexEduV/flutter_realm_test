import 'package:get_it/get_it.dart';

import '../../../data/services/time_service_impl.dart';
import '../../../domain/services/time_service.dart';
import '../../../utils/date_formatter.dart';

void registerInfrastructureModule(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton<TimeService>(() => TimeServiceImpl());
  serviceLocator.registerLazySingleton(() => DateFormatter(serviceLocator(), serviceLocator()));
}
