import 'package:get_it/get_it.dart';
import 'package:test_flutter_project/domain/repositories/car_repository.dart';
import 'package:test_flutter_project/presentation/features/search/search_page_cubit.dart';

import '../l10n/app_localisations_cubit.dart';

void registerSearchModule(GetIt serviceLocator) {
  serviceLocator.registerFactory(
    () => SearchPageCubit(serviceLocator<CarRepository>(), serviceLocator<AppLocalisationsCubit>()),
  );
}
