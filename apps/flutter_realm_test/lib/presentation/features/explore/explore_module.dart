import 'package:get_it/get_it.dart';

import '../../../domain/usecases/articles/fetch_articles_use_case.dart';
import '../../../domain/usecases/database/get_car_by_id_use_case.dart';
import '../../../domain/usecases/database/sync_cars_use_case.dart';
import '../../../domain/usecases/database/watch_cars_use_case.dart';
import 'explore_page_cubit.dart';

void registerExploreModule(GetIt serviceLocator) {
  serviceLocator.registerFactory(
    () => ExplorePageCubit(
      serviceLocator<WatchCarsUseCase>(),
      serviceLocator<SyncCarsUseCase>(),
      serviceLocator<FetchArticlesUseCase>(),
      serviceLocator<GetCarByIdUseCase>(),
    ),
  );
}
