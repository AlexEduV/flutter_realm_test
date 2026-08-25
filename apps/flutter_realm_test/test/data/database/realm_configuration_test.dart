// Migration-callback behaviour requires a real Realm open (native library) and
// cannot be unit-tested with flutter test. Those cases belong in integration
// tests. What can be verified here is that init() builds the right
// LocalConfiguration — without ever opening the database.

import 'package:flutter_test/flutter_test.dart';
import 'package:realm/realm.dart';
import 'package:test_flutter_project/data/database/realm_configuration.dart';

void main() {
  group('RealmConfiguration', () {
    late RealmConfiguration realmConfig;

    setUp(() {
      realmConfig = RealmConfiguration();
    });

    test('init creates a LocalConfiguration', () {
      realmConfig.init();

      expect(realmConfig.instance, isA<LocalConfiguration>());
    });

    test('init sets schema version to 31', () {
      realmConfig.init();

      final config = realmConfig.instance as LocalConfiguration;
      expect(config.schemaVersion, 31);
    });

    test('init registers all five required schemas', () {
      realmConfig.init();

      final schemaNames = realmConfig.instance.schemaObjects.map((s) => s.name);
      expect(schemaNames, containsAll(['Car', 'Person', 'User', 'LastSeenCar', 'Engine']));
    });

    test('instance throws before init is called', () {
      expect(() => realmConfig.instance, throwsA(isA<Error>()));
    });
  });
}
