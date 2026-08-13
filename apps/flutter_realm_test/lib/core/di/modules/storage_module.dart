import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';

import '../../../common/extensions/get_it_extension.dart';
import '../../../data/data_sources/local/realm_local_storage.dart';
import '../../../data/database/realm_configuration.dart';
import '../../../domain/data_sources/local/base_local_storage.dart';

void registerStorageModule(GetIt serviceLocator) {
  if (serviceLocator.isNotRegistered<Realm>()) {
    try {
      final config = RealmConfiguration()..init();
      serviceLocator.registerLazySingleton<Realm>(() => Realm(config.instance));
    } catch (e) {
      debugPrint('Could not open realm');
    }
  }

  if (serviceLocator.isNotRegistered<BaseLocalStorage>()) {
    try {
      serviceLocator.registerLazySingleton<BaseLocalStorage>(
        () => RealmLocalStorage(serviceLocator()),
      );
    } catch (e) {
      debugPrint('Could not register local storage');
    }
  }
}
