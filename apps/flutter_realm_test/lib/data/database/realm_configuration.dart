import 'package:realm/realm.dart';

import '../models/scheme.dart';

class RealmConfiguration {
  late Configuration _config;

  void init() {
    _config = Configuration.local(
      [Car.schema, Person.schema, User.schema, LastSeenCar.schema, Engine.schema],
      schemaVersion: 29,
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

        if (oldVersion < 28) {
          final oldCars = migration.oldRealm.all('Car');
          final newCars = migration.newRealm.all<Car>();

          for (var i = 0; i < oldCars.length; i++) {
            final oldCar = oldCars[i];
            final newCar = newCars[i];

            // Move the old 'kilometers' to 'mileage'
            int? oldCarMileage;
            try {
              oldCarMileage = oldCar.dynamic.get<int>('kilometers');
            } catch (e) {
              oldCarMileage = null;
            }
            if (oldCarMileage == null) continue;

            newCar.mileage = oldCarMileage;
          }
        }

        if (oldVersion < 29) {
          final oldCars = migration.oldRealm.all('Car');
          final newCars = migration.newRealm.all<Car>();

          for (var i = 0; i < oldCars.length; i++) {
            final oldCar = oldCars[i];
            final newCar = newCars[i];

            // Move the old 'kilometers' to 'mileage'
            String? oldCarFuelType;
            try {
              oldCarFuelType = oldCar.dynamic.get<String?>('fuelType');
            } catch (e) {
              oldCarFuelType = null;
            }
            if (oldCarFuelType == null) continue;

            newCar.engine = Engine(fuelType: oldCarFuelType);
          }
        }
      },
    );
  }

  Configuration get instance => _config;
}
