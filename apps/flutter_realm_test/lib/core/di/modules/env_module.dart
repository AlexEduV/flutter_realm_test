import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import '../../../data/data_sources/local/env_local_data_source_impl.dart';
import '../../../data/repositories/env_repository_impl.dart';
import '../../../domain/data_sources/local/env_local_data_source.dart';
import '../../../domain/repositories/env_repository.dart';
import '../../../domain/usecases/env/get_env_data_by_key_use_case.dart';
import '../../../domain/usecases/env/init_env_use_case.dart';

Future<void> registerEnvModule(GetIt serviceLocator) async {
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
