import 'package:get_it/get_it.dart';
import 'package:test_flutter_project/presentation/features/share/share_cubit.dart';

import '../../../data/repositories/share_repository_impl.dart';
import '../../../data/services/share_service_impl.dart';
import '../../../domain/repositories/share_repository.dart';
import '../../../domain/services/share_service.dart';

void registerShareModule(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton<ShareService>(() => ShareServiceImpl());

  serviceLocator.registerLazySingleton<ShareRepository>(
    () => ShareRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerFactory(() => ShareCubit(serviceLocator()));
}
