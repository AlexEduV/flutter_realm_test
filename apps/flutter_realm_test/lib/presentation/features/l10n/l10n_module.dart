import 'package:get_it/get_it.dart';

import 'app_localisations_cubit.dart';

void registerL10nModule(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton(() => AppLocalisationsCubit());
}
