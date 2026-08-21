import 'package:realm/realm.dart';

import '../../models/scheme.dart';

void migrateV30(Migration migration) {
  final newUsers = migration.newRealm.all<User>();

  for (final user in newUsers) {
    user.isLocationPermissionGranted = null;
  }
}
