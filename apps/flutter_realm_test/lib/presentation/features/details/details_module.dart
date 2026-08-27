import 'package:get_it/get_it.dart';

import '../../../data/data_sources/local/car_color_local_data_source_impl.dart';
import '../../../data/repositories/car_color_repository_impl.dart';
import '../../../domain/data_sources/local/car_colors_local_data_source.dart';
import '../../../domain/repositories/car_color_repository.dart';
import '../../../domain/usecases/database/get_car_by_id_use_case.dart';
import '../../../domain/usecases/inbox/get_conversation_by_owner_id_use_case.dart';
import 'details_page_cubit.dart';

void registerDetailsModule(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton<CarColorLocalDataSource>(
    () => CarColorLocalDataSourceImpl(),
  );

  serviceLocator.registerLazySingleton<CarColorRepository>(
    () => CarColorRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => DetailsPageCubit(
      serviceLocator<CarColorRepository>(),
      serviceLocator<GetCarByIdUseCase>(),
      serviceLocator<GetConversationByOwnerIdUseCase>(),
    ),
  );
}
