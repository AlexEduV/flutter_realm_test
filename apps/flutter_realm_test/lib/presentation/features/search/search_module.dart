import 'package:get_it/get_it.dart';
import 'package:test_flutter_project/presentation/features/search/search_page_cubit.dart';

import '../../../domain/usecases/database/get_all_cars_use_case.dart';
import '../../../domain/usecases/database/watch_cars_use_case.dart';
import '../l10n/app_localisations_cubit.dart';

void registerSearchModule(GetIt serviceLocator) {
  serviceLocator.registerFactory(
    () => SearchPageCubit(
      serviceLocator<GetAllCarsUseCase>(),
      serviceLocator<WatchCarsUseCase>(),
      serviceLocator<AppLocalisationsCubit>(),
    ),
  );
}
