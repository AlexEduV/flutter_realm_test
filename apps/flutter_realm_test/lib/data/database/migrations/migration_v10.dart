import 'package:realm/realm.dart';

import '../../models/scheme.dart';

void migrateV10(Migration migration) {
  final oldUsers = migration.oldRealm.all('User');
  final newUsers = migration.newRealm.all<User>();

  // Loop through old data to ensure uniqueness before applying the PK
  for (var i = 0; i < oldUsers.length; i++) {
    final oldUser = oldUsers[i];
    final newUser = newUsers[i];

    // Ensure userId is unique and not null
    newUser.userId = oldUser.dynamic.get<String>('userId');
  }
}
