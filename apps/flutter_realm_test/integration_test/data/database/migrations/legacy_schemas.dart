// Legacy Realm schema snapshots used only by migration integration tests.
//
// Each class captures the schema as it existed BEFORE a specific migration,
// allowing tests to seed a Realm file at the old version and verify that the
// migration callback produces the correct new state.
//
// @MapTo ensures the Dart class name maps to the canonical Realm class name
// ('User' / 'Car'), so the migration callback sees the right type names.
import 'package:realm/realm.dart';

part 'legacy_schemas.realm.dart';

/// User schema before v27 migration.
/// Had a single `name` field instead of separate `firstName` / `lastName`.
@RealmModel()
@MapTo('User')
class _LegacyUserV26 {
  @PrimaryKey()
  late String userId;
  late String name;
}

/// Car schema before v28 migration.
/// Had `kilometers` instead of `mileage`.
@RealmModel()
@MapTo('Car')
class _LegacyCarV27 {
  @PrimaryKey()
  late ObjectId id;
  late String carId;
  late String manufacturer;
  late String type;
  int? kilometers;
}

/// Car schema before v29 migration.
/// Had `fuelType` as a direct field instead of a nested `Engine` object.
@RealmModel()
@MapTo('Car')
class _LegacyCarV28 {
  @PrimaryKey()
  late ObjectId id;
  late String carId;
  late String manufacturer;
  late String type;
  String? fuelType;
}
