import 'package:get_it/get_it.dart';

import 'home_bottom_bar_cubit.dart';

void registerHomeBottomBarModule(GetIt serviceLocator) {
  serviceLocator.registerFactory(() => HomeBottomBarCubit());
}
