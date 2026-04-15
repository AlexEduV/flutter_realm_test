//todo: these tests are unfinished;

/*
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:realm/realm.dart';
import 'package:test_flutter_project/data/database/realm_configuration.dart';
import 'package:test_flutter_project/data/models/scheme.dart';

import 'realm_configuration_test.mocks.dart';

@GenerateMocks([Car, Realm, Migration, User])
void main() {
  group('RealmConfiguration', () {
    late RealmConfiguration realmConfig;

    setUp(() {
      realmConfig = RealmConfiguration();
    });

    test('init sets up configuration with correct schemas and version', () {
      realmConfig.init();
      final config = realmConfig.instance;

      expect(config, isA<Configuration>());
      expect(config.schemaVersion, 27);
      expect(
        config.schemas,
        containsAll([Car.schema, Person.schema, User.schema, LastSeenCar.schema]),
      );
    });

    test('migrationCallback for oldVersion < 2 adds object id to Car', () {
      realmConfig.init();
      final config = realmConfig.instance;

      // Setup migration mocks
      final migration = MockMigration();
      final oldRealm = MockRealm();
      final oldCars = [MockCar(), MockCar()];
      when(migration.oldRealm).thenReturn(oldRealm);
      when(oldRealm.all('Car')).thenReturn(oldCars);

      // Mock findInNewRealm
      final newCar = MockCar();
      when(migration.findInNewRealm<Car>(any)).thenReturn(newCar);

      // Call migration callback
      config.migrationCallback!(migration, 1);

      // Verify newCar.id is set
      verify(newCar.id = anyNamed('id')).called(1);
    });

    test('migrationCallback for oldVersion < 10 sets userId for User', () {
      realmConfig.init();
      final config = realmConfig.instance;

      final migration = MockMigration();
      final oldRealm = MockRealm();
      final newRealm = MockRealm();
      final oldUsers = [MockUser()];
      final newUsers = [MockUser()];
      when(migration.oldRealm).thenReturn(oldRealm);
      when(migration.newRealm).thenReturn(newRealm);
      when(oldRealm.all('User')).thenReturn(oldUsers);
      when(newRealm.all<User>()).thenReturn(newUsers);

      // Mock dynamic.get
      when(oldUsers[0].dynamic.get<String>('userId')).thenReturn('uniqueId');

      config.migrationCallback!(migration, 5);

      verify(newUsers[0].userId = 'uniqueId').called(1);
    });

    test('migrationCallback for oldVersion < 27 moves name to firstName and lastName', () {
      realmConfig.init();
      final config = realmConfig.instance;

      final migration = MockMigration();
      final oldRealm = MockRealm();
      final newRealm = MockRealm();
      final oldUsers = [MockUser()];
      final newUsers = [MockUser()];
      when(migration.oldRealm).thenReturn(oldRealm);
      when(migration.newRealm).thenReturn(newRealm);
      when(oldRealm.all('User')).thenReturn(oldUsers);
      when(newRealm.all<User>()).thenReturn(newUsers);

      // Mock dynamic.get
      when(oldUsers[0].dynamic.get<String>('name')).thenReturn('John Doe');

      config.migrationCallback!(migration, 20);

      verify(newUsers[0].firstName = 'John').called(1);
      verify(newUsers[0].lastName = 'Doe').called(1);
    });

    test('instance returns the configuration', () {
      realmConfig.init();
      expect(realmConfig.instance, isA<Configuration>());
    });
  });
}

 */

void main() {}
