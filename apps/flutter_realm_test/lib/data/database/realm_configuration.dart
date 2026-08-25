import 'package:realm/realm.dart';
import 'package:test_flutter_project/data/database/migrations/migration_v10.dart';
import 'package:test_flutter_project/data/database/migrations/migration_v2.dart';
import 'package:test_flutter_project/data/database/migrations/migration_v27.dart';
import 'package:test_flutter_project/data/database/migrations/migration_v28.dart';
import 'package:test_flutter_project/data/database/migrations/migration_v29.dart';
import 'package:test_flutter_project/data/database/migrations/migration_v30.dart';

import '../models/scheme.dart';

class RealmConfiguration {
  late Configuration _config;

  void init() {
    _config = Configuration.local(
      [Car.schema, Person.schema, User.schema, LastSeenCar.schema, Engine.schema],
      schemaVersion: 31,
      migrationCallback: (migration, oldVersion) {
        if (oldVersion < 2) migrateV2(migration);
        if (oldVersion < 10) migrateV10(migration);
        if (oldVersion < 27) migrateV27(migration);
        if (oldVersion < 28) migrateV28(migration);
        if (oldVersion < 29) migrateV29(migration);
        if (oldVersion < 30) migrateV30(migration);
      },
    );
  }

  Configuration get instance => _config;
}
