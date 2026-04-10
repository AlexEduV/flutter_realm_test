import 'package:realm/realm.dart';

import '../models/scheme.dart';

class RealmConfiguration {
  late Configuration _config;

  void init() {
    _config = Configuration.local(
      [Car.schema, Person.schema, User.schema, LastSeenCar.schema],
      schemaVersion: 27,
      migrationCallback: (migration, oldVersion) {
        //add object id
        if (oldVersion < 2) {
          final oldCars = migration.oldRealm.all('Car');

          for (final oldCar in oldCars) {
            final newCar = migration.findInNewRealm<Car>(oldCar);
            if (newCar != null) {
              newCar.id = ObjectId();
            }
          }
        }

        if (oldVersion < 10) {
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

        if (oldVersion < 27) {
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

            final parts = oldName.split(' ');
            newUser.firstName = parts.isNotEmpty ? parts.first : '';
            newUser.lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';
          }
        }
      },
    );
  }

  Configuration get instance => _config;
}
