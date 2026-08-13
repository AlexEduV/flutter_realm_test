import 'package:realm/realm.dart';

import '../../models/scheme.dart';

void migrateV28(Migration migration) {
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
