import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_project/data/data_sources/remote/shared_preferences_storage.dart';
import 'package:test_flutter_project/domain/data_sources/remote/app_remote_storage.dart';

import '../../../common/extensions/get_it_extension.dart';
import '../../../data/data_sources/local/realm_local_storage.dart';
import '../../../data/database/realm_configuration.dart';
import '../../../domain/data_sources/local/app_local_storage.dart';

Future<void> registerStorageModule(GetIt serviceLocator) async {
  if (serviceLocator.isNotRegistered<Realm>()) {
    try {
      final config = RealmConfiguration()..init();
      serviceLocator.registerLazySingleton<Realm>(() => Realm(config.instance));
    } catch (e) {
      debugPrint('Could not open realm');
    }
  }

  if (serviceLocator.isNotRegistered<AppLocalStorage>()) {
    try {
      serviceLocator.registerLazySingleton<AppLocalStorage>(
        () => RealmLocalStorage(serviceLocator()),
        dispose: (storage) => (storage as RealmLocalStorage).close(),
      );
    } catch (e) {
      debugPrint('Could not register local storage');
    }
  }

  if (serviceLocator.isNotRegistered<AppRemoteStorage>()) {
    try {
      final prefs = SharedPreferencesAsync();

      serviceLocator.registerLazySingleton<AppRemoteStorage>(() => SharedPreferencesStorage(prefs));
    } catch (e) {
      debugPrint('Could not register remote storage');
    }
  }
}
