// Migration integration tests.
//
// Each test seeds a Realm file at the OLD schema version, then reopens it at
// the next version with only the relevant migration callback applied.
// This verifies the Realm wiring — index alignment, dynamic field access,
// null guards — which cannot be reached without a live Realm on disk.
//
// v2 and v10 require reconstructing schemas from before ObjectId PKs and
// before userId became a primary key; those are candidates for future tests
// once the exact old schemas are recovered from git history.

@Tags(['integration'])
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:realm/realm.dart';
import 'package:test_flutter_project/data/database/migrations/migration_v27.dart';
import 'package:test_flutter_project/data/database/migrations/migration_v28.dart';
import 'package:test_flutter_project/data/database/migrations/migration_v29.dart';
import 'package:test_flutter_project/data/models/scheme.dart';

import 'legacy_schemas.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late String realmPath;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('realm_migration_test_');
    realmPath = '${tempDir.path}/migration.realm';
  });

  tearDown(() {
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  // ---------------------------------------------------------------------------
  // v27 — name → firstName + lastName
  // ---------------------------------------------------------------------------

  group('migrateV27', () {
    void seedV26(String path) {
      final config = Configuration.local(
        [LegacyUserV26.schema],
        path: path,
        schemaVersion: 26,
      );
      final realm = Realm(config);
      realm.write(() {
        realm.add(LegacyUserV26('uid1', 'John Doe'));
        realm.add(LegacyUserV26('uid2', 'Jane Van Der Berg'));
        realm.add(LegacyUserV26('uid3', 'Solo'));
      });
      realm.close();
    }

    Realm openV27(String path) {
      return Realm(Configuration.local(
        [Car.schema, Person.schema, User.schema, LastSeenCar.schema, Engine.schema],
        path: path,
        schemaVersion: 27,
        migrationCallback: (migration, _) => migrateV27(migration),
      ));
    }

    test('splits two-word name into firstName and lastName', () {
      seedV26(realmPath);
      final realm = openV27(realmPath);

      final john = realm.all<User>().firstWhere((u) => u.userId == 'uid1');
      expect(john.firstName, 'John');
      expect(john.lastName, 'Doe');

      realm.close();
    });

    test('joins everything after first word into lastName', () {
      seedV26(realmPath);
      final realm = openV27(realmPath);

      final jane = realm.all<User>().firstWhere((u) => u.userId == 'uid2');
      expect(jane.firstName, 'Jane');
      expect(jane.lastName, 'Van Der Berg');

      realm.close();
    });

    test('single-word name goes to firstName with empty lastName', () {
      seedV26(realmPath);
      final realm = openV27(realmPath);

      final solo = realm.all<User>().firstWhere((u) => u.userId == 'uid3');
      expect(solo.firstName, 'Solo');
      expect(solo.lastName, '');

      realm.close();
    });

    test('migrates all users in the database', () {
      seedV26(realmPath);
      final realm = openV27(realmPath);

      expect(realm.all<User>().length, 3);
      for (final user in realm.all<User>()) {
        expect(user.firstName, isNotEmpty);
      }

      realm.close();
    });
  });

  // ---------------------------------------------------------------------------
  // v28 — kilometers → mileage
  // ---------------------------------------------------------------------------

  group('migrateV28', () {
    void seedV27(String path) {
      final config = Configuration.local(
        [LegacyCarV27.schema],
        path: path,
        schemaVersion: 27,
      );
      final realm = Realm(config);
      realm.write(() {
        realm.add(LegacyCarV27(ObjectId(), 'car1', 'Toyota', 'car', kilometers: 12000));
        realm.add(LegacyCarV27(ObjectId(), 'car2', 'Honda', 'bike', kilometers: 350));
        realm.add(LegacyCarV27(ObjectId(), 'car3', 'Ford', 'car'));
      });
      realm.close();
    }

    Realm openV28(String path) {
      return Realm(Configuration.local(
        [Car.schema, Person.schema, User.schema, LastSeenCar.schema, Engine.schema],
        path: path,
        schemaVersion: 28,
        migrationCallback: (migration, _) => migrateV28(migration),
      ));
    }

    test('copies a large kilometers value to mileage', () {
      seedV27(realmPath);
      final realm = openV28(realmPath);

      final car = realm.all<Car>().firstWhere((c) => c.carId == 'car1');
      expect(car.mileage, 12000);

      realm.close();
    });

    test('copies a small non-zero kilometers value correctly', () {
      seedV27(realmPath);
      final realm = openV28(realmPath);

      final car = realm.all<Car>().firstWhere((c) => c.carId == 'car2');
      expect(car.mileage, 350);

      realm.close();
    });

    test('leaves mileage null when kilometers field was absent in old schema', () {
      seedV27(realmPath);
      final realm = openV28(realmPath);

      // int? mileage = 500 is a Dart-level default for unmanaged objects only;
      // Realm migration leaves fields absent in the old schema as null.
      final car = realm.all<Car>().firstWhere((c) => c.carId == 'car3');
      expect(car.mileage, isNull);

      realm.close();
    });
  });

  // ---------------------------------------------------------------------------
  // v29 — fuelType field → Engine embedded object
  // ---------------------------------------------------------------------------

  group('migrateV29', () {
    void seedV28(String path) {
      final config = Configuration.local(
        [LegacyCarV28.schema],
        path: path,
        schemaVersion: 28,
      );
      final realm = Realm(config);
      realm.write(() {
        realm.add(LegacyCarV28(ObjectId(), 'car1', 'Tesla', 'car', fuelType: 'electric'));
        realm.add(LegacyCarV28(ObjectId(), 'car2', 'Toyota', 'car', fuelType: 'gasoline'));
        realm.add(LegacyCarV28(ObjectId(), 'car3', 'Bike Co', 'bike'));
      });
      realm.close();
    }

    Realm openV29(String path) {
      return Realm(Configuration.local(
        [Car.schema, Person.schema, User.schema, LastSeenCar.schema, Engine.schema],
        path: path,
        schemaVersion: 29,
        migrationCallback: (migration, _) => migrateV29(migration),
      ));
    }

    test('creates Engine with correct fuelType', () {
      seedV28(realmPath);
      final realm = openV29(realmPath);

      final tesla = realm.all<Car>().firstWhere((c) => c.carId == 'car1');
      expect(tesla.engine, isNotNull);
      expect(tesla.engine!.fuelType, 'electric');

      realm.close();
    });

    test('creates Engine for each non-null fuelType', () {
      seedV28(realmPath);
      final realm = openV29(realmPath);

      final toyota = realm.all<Car>().firstWhere((c) => c.carId == 'car2');
      expect(toyota.engine!.fuelType, 'gasoline');

      realm.close();
    });

    test('leaves engine null when fuelType field was absent', () {
      seedV28(realmPath);
      final realm = openV29(realmPath);

      final bike = realm.all<Car>().firstWhere((c) => c.carId == 'car3');
      expect(bike.engine, isNull);

      realm.close();
    });
  });
}
