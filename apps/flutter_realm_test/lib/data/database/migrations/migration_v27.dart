import 'package:realm/realm.dart';

import '../../models/scheme.dart';

void migrateV27(Migration migration) {
  final oldUsers = migration.oldRealm.all('User');
  final newUsers = migration.newRealm.all<User>();

  for (var i = 0; i < oldUsers.length; i++) {
    final oldUser = oldUsers[i];
    final newUser = newUsers[i];

    // Move the old 'name' to 'firstName'
    String? oldName;
    try {
      oldName = oldUser.dynamic.get<String>('name');
    } catch (e) {
      oldName = null;
    }
    if (oldName == null) continue;

    final (firstName: firstName, lastName: lastName) = splitFullName(oldName);
    newUser.firstName = firstName;
    newUser.lastName = lastName;
  }
}

({String firstName, String lastName}) splitFullName(String name) {
  final parts = name.split(' ');
  return (
    firstName: parts.isNotEmpty ? parts.first : '',
    lastName: parts.length > 1 ? parts.sublist(1).join(' ') : '',
  );
}
