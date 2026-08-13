import 'package:realm/realm.dart';

import '../../models/scheme.dart';

void migrateV2(Migration migration) {
  //add object id
  final oldCars = migration.oldRealm.all('Car');

  for (final oldCar in oldCars) {
    final newCar = migration.findInNewRealm<Car>(oldCar);
    if (newCar != null) {
      newCar.id = ObjectId();
    }
  }
}
