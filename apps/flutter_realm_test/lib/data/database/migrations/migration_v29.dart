import 'package:realm/realm.dart';

import '../../models/scheme.dart';

void migrateV29(Migration migration) {
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
